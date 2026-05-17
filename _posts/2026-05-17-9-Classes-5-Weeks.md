---
title: Nine Classes, Five Weeks, One Radar
description: A postmortem on five weeks of bird radar classification for AI Cup 2026.
date: 2026-05-17
repo_url: https://github.com/anshuma1i/epoch_ai
permalink: /projects/epoch-ai/ai-cup-2026/
---

# Nine Classes, Five Weeks, One Radar

## AI Cup 2026

AI Cup 2026 was the national AI talent benchmark organized by Team Epoch at TU Delft, with TNO as the challenge provider and AIC4NL as the umbrella host. It was the first competition of its kind in the Netherlands: a five-week, cross-university contest pulling student teams from across the top Dutch institutions into a single national benchmark. The 2026 edition ran from February 13 to April 14 and split scoring across two tracks. The Performance Track, hosted on Kaggle, was worth 60 percent of the final mark and evaluated submissions on a held-out test set. The Implementation Track, worth the remaining 40 percent, required teams to submit a written design for how their model would actually be deployed inside a wind farm system: hardware, labelling pipeline, explainability, mitigation strategy, privacy. 88 teams validated and submitted across the two tracks.

The challenge centered on Windpark Eemshaven on the north Dutch coast, where TNO's MAX Avian Radar generates tracks for every flying object the system sees. The competition task was nine-class classification of those tracks: Clutter, Cormorants, Pigeons, Ducks, Geese, Gulls, Birds of Prey, Waders, Songbirds. The training set contained 2,601 labelled tracks; the test set 1,872. The metric was macro-averaged Average Precision, which weights all nine classes equally regardless of their share of the data. With Gulls at 57.8 percent of the training set and Cormorants at 1.5 percent, that metric was the central problem of the competition. A model that did well on Gulls and badly on the rare classes was a model that scored poorly.

I entered as `subarctic1712` with one collaborator, Anshumali Mehta. He wrote the initial KNMI and Open-Meteo weather-merge scripts and contributed ideas through the run. I wrote the rest of the modelling code: feature engineering, the two-stage architecture, the ensemble, the diagnostics. We co-authored the Implementation Track report.

The work that follows ended at a final out-of-fold mAP of 0.7168 on private validation, 11th in the Implementation Track, and 29th overall across the combined tracks. The path between those numbers and the empty `solution.py` I started with was longer than the leaderboard makes it look.

## The problem

The MAX Avian Radar is a Frequency-Modulated Continuous-Wave X-band system operated by TNO. It scans the airspace around Eemshaven at 360 degrees and produces a track for every flying object it can resolve, regardless of whether the object is a bird, an insect cloud, a drone, or ground clutter. Each track in the competition dataset contained two parts: a sequence of 15 to 30 trajectory points (longitude, latitude, altitude, timestamp, Radar Cross Section) encoded as an EWKB hex string, and a row of tabular metadata that the radar's signal-processing chain had already derived: airspeed, altitude range, duration, a categorical bird-size estimate, observation timestamp, and a few derived directional values.

Nine target classes covered the full output space: Clutter for anything not a bird, then Cormorants, Pigeons, Ducks, Geese, Gulls, Birds of Prey, Waders, and Songbirds. The imbalance was severe. Gulls accounted for 1,503 of the 2,601 training tracks. Cormorants had 40. Geese 83, Waders 120, Birds of Prey 196. The full ratio between the most common and rarest class was 37.6 to 1.

Three properties of the data made this hard before any modelling started. The trajectories were short, only 15 to 30 points, which ruled out spectral and periodicity features that work well on longer movement data. All tracks came from the same wind park, so geospatial position carried no class signal worth exploiting. And the radar produces kinematic and RCS-based observations only; there is no visual channel that an ornithologist would use to separate a Gull from a Cormorant.

Macro-averaged Average Precision sets the stakes. A confident, well-ranked Gull prediction is worth exactly as much as a confident, well-ranked Cormorant prediction. With 40 Cormorant samples, that meant a few dozen trajectories drove roughly 11 percent of the final score. The whole competition was a fight to make the rare classes rank well without giving up the common ones.

## Decoding the trajectory

The geometry column was the only place the actual flight path lived. The rest of the row was a flat summary: airspeed, altitude bounds, duration, bird-size category. To get the shape of the track itself you had to decode the EWKB. The competition organizers documented the format on the Kaggle page; `shapely.wkb.loads` turns each hex string into a `LineStringZ`, and you iterate through the coordinates to get the per-point series.

Each point gave four values: longitude, latitude, altitude in meters, and Radar Cross Section in decibels. The first useful artifact in the repo was a small extraction function that walked the points and returned a dictionary of derived features. Once you had displacement vectors between consecutive points, almost everything else fell out: step distances and their distribution, total path length, straight-line displacement, tortuosity from cumulative bearing change, a sharp-turn ratio, sinuosity. Mean and standard deviation of altitude, climb rate, descent rate. Speed statistics came from displacement divided by the timestamp delta. RCS statistics came from the same loop. By the end of feature work a single 15-to-30 point trajectory was expanding into 33 trajectory features feeding the model.

The lesson from this was that the trajectory was where the discriminative signal lived. The flat metadata was useful but largely redundant with what you could derive yourself; airspeed and altitude range were trivially recomputable from the points. The trajectory let you ask the questions the metadata never could. Does this thing fly in straight lines? Does it change direction sharply? How quickly does its altitude vary? Those questions separate a soaring raptor from a foraging gull in ways the bird-size category cannot.

The flat metadata gave you a baseline. The trajectory features were what made any of the rest of the work matter. My first submission, built on only the columns the organizers supplied, scored 0.47 on the public leaderboard. Adding trajectory geometry and weather context alone pushed that into the high 0.6s before any serious modelling work happened. Every ensemble member, every oversampling experiment, every calibration step that followed was operating on top of the geometry, not in place of it.

## Features carried more weight than models

Beyond the trajectory geometry, the largest piece of feature work was weather. The Eemshaven coast is a noisy meteorological environment, and bird behaviour responds to it: gulls forage in specific tidal and wind states, raptors thermal in clear daytime air, waterfowl migrate on tailwinds. The original training CSV had no weather data attached. Anshumali wrote the first two merge scripts. The KNMI version pulled hourly observations from station 286, the closest available land station to Eemshaven, and joined them by nearest preceding hour. The Open-Meteo version called the historical archive API at the track's spatial centroid and merged on the trajectory's midpoint timestamp.

In a grid search over both sources I ended up running Open-Meteo as the default. KNMI alone scored worse, and combining the two did not improve on Open-Meteo alone. The likely reason is that station 286 sits inland by several kilometers, while the Open-Meteo gridded data interpolates to the actual radar location. Open-Meteo contributed 16 features: temperature, humidity, dew point, wind speed and direction at 10m, gusts, pressure, cloud cover, several radiation channels, and a sunshine duration. Wind direction was encoded with sin/cos pairs to handle the 359-to-0 wraparound cleanly.

The most useful weather features were not the raw measurements but the interactions. Track heading from the trajectory plus wind direction from the weather gave you true tailwind and crosswind components for that specific flight. RCS divided by airspeed gave a rough mass-per-unit-motion proxy. Altitude-adjusted wind via the Hellmann power law (exponent 0.143) gave you the wind a bird was actually flying through at its observed height, not the value reported at 10 meters. Six interaction features came out of this.

Not everything I added helped. I once spent an afternoon writing 17 RCS-based signature features (FFT energy, changepoint counts, histogram bins, temporal moments) and reverted them in a single commit when they failed to improve out-of-fold mAP. The geometry and weather features added up. Signal-shape engineering on a 15-point sequence did not.

## The two-stage trick and the imbalance fight

The 37.6:1 ratio is hard to convey until you watch a baseline model behave under it. A vanilla LightGBM on the full nine-class problem learned to predict Gulls confidently and everything else with washed-out probabilities. The macro-mAP punished it. The shift that produced the largest single architectural jump was not a hyperparameter; it was splitting the problem into two stages.

Stage 1 was a binary LightGBM classifier, Gull versus non-Gull. Stage 2 was a separate model trained only on the eight non-Gull classes. At inference the two outputs combined trivially: `P(Gull)` from Stage 1, and `P(class_k) = (1 - P(Gull)) * P(class_k | non-Gull)` from Stage 2. This factored the dominant class out of the multi-class learning problem entirely; Stage 2 saw a much flatter distribution to model. The two-stage configuration gained roughly 0.005 OOF mAP over the equivalent single-stage ensemble, the largest single architecture-level win of the project.

Inside Stage 2 the imbalance was still severe (Cormorants at 40 samples versus Songbirds at 614), and I burned weeks on oversampling experiments. SMOTENC was the baseline at 0.6999 OOF mAP. BorderlineSMOTE was marginally better at 0.7003. ADASYN, which generates more synthetic samples for harder-to-classify instances, jumped to 0.7041 and stayed the best single method. I also wrote a trajectory-level augmentation that ran before feature extraction: per-point spatial jitter (about 3 meters in lat/lon, 2 meters altitude, 0.3 dB RCS), random rotation of displacement vectors, and a small time-warp. At full jitter it scored 0.7028; at halved jitter 0.7059.

The two did not stack. Running ADASYN and trajectory augmentation together dropped back to 0.7000, almost exactly the SMOTENC baseline. They were compensating for the same shortage of minority-class signal, and combining them added noise without information.

Class weighting and a targeted version of that same trajectory augmentation filled the remaining gaps. LightGBM ran with `class_weight='balanced'`, CatBoost with `auto_class_weights='Balanced'`. The augmentation function also ran in a class-specific mode (`--boost-weak 3`) restricted to Cormorants, Waders, and Geese: each row in those classes spawned two additional synthetic copies before feature extraction, so the tortuosity, climb rate, and RCS statistics computed on the augmented copies were genuinely different vectors rather than duplicate rows. None of these tricks was elegant. All of them helped.

## The slow grind from 0.66 to 0.7168

Two-stage architecture, ADASYN, weather features, and trajectory augmentation got me to about 0.66 OOF mAP. The remaining 0.05 came from a steady series of model-level changes, none of them individually impressive.

The first step was ensembling. A single LightGBM scored 0.6550. Adding a CatBoost in parallel and averaging the two probability vectors lifted it to 0.6652, a margin small enough to question. Adding XGBoost as a third member produced the largest jump of this phase: 0.7087, plus 0.044 over the two-model average. Tree-boosted models look similar from the outside but disagree more on individual predictions than you would expect, and the third disagreement broke ties the first two could not.

After three members the gains came in fractions of a percent. Per-class probability calibration on out-of-fold predictions added 0.001: Platt scaling for classes with fewer than 100 positive samples, Isotonic regression for the larger ones, then row renormalisation to keep the two-stage combination math correct. Tuning ensemble weights by grid search in 5 percent increments settled at LightGBM 0.45, CatBoost 0.25, XGBoost 0.30, scoring 0.7119. Averaging across 5 random seeds reduced fold-to-fold variance but did not move the mean meaningfully on its own.

The final submission used rank averaging instead of weighted probability averaging. For each model's per-class output, you convert predictions to percentile ranks across the test set, then average the ranks. Rank averaging cares only about ordering, which makes it insensitive to calibration-scale differences between models. With rank averaging on top of calibration, 5-seed averaging, and the full three-model ensemble, the final OOF mAP landed at 0.7168.

That is 0.0618 of margin between the single LightGBM baseline and the final number, accumulated in increments averaging about 0.01 each. Past 0.70 the work stops feeling like research and starts feeling like maintenance.

## Things that should have worked and did not

Two of the most time-consuming experiments produced nothing usable, and the way they failed was instructive.

The first was a 1D CNN trained on the raw trajectory sequences. Six input channels (dx, dy, dz, dt, speed, RCS), sequences padded or truncated to 128 steps, three convolutional blocks at 32, 64, and 128 filters, adaptive pooling, then a 32-dimensional embedding head. Focal loss with class-balanced alpha, AdamW with cosine annealing, rotation and jitter augmentation in the data loader, Gull undersampling to 600 samples. The pipeline ran end to end (`extract_cnn_features.py`, `join_cnn_features.py`, `solution_v2.py`) and the CNN-augmented models landed in the same neighborhood as the pure tabular pipeline. The likely reason is sequence length: 15 to 30 points padded out to 128 leaves a deep model with mostly mask to chew on, and there is nothing in a 20-point flight path that the handcrafted features (tortuosity, sinuosity, climb rate, RCS percentiles) were not already capturing. Deep learning works when there is unmodelled structure left in the raw signal; on this dataset, there was not.

The second was pseudo-labelling. Predict on the test set, threshold the predictions at 0.95, add the high-confidence test samples to the training set with their predicted labels, retrain. The OOF mAP jumped from 0.7041 to 0.7148, a 0.011 lift that would have been the largest single gain of the project. I shipped one submission against it and then started looking at the numbers more carefully. 936 of the 1,872 test samples cleared the 0.95 threshold; 811 of those were Gulls. The pseudo-labelled test rows were appearing across cross-validation folds, so the "out-of-fold" validation was now partly training on what it was validating against. The lift was real in the sense that I had measured it. It did not reflect held-out generalisation. I left the flag in the codebase and removed it from the production config.

The pattern across both failures is consistent. Methods that add genuinely new information compound. Methods that re-express what the model already has do not. The expensive failures are the ones that look like they should be in the first category and turn out to be in the second.

## The other half of the competition

The Implementation Track was scored separately from the model. The submission was a written design, four pages due on March 24, on how the AI system would actually live in a wind farm: hardware, labelling pipeline, explainability, mitigation, privacy. It was worth 40 percent of the combined score and rewarded a completely different kind of work than the modelling did.

The proposal we wrote opened with a system architecture fusing macro-scale FMCW X-band radar (the same MAX Avian setup the competition data came from) with off-the-shelf PTZ cameras mounted on the static lower sections of the turbine tower. The cameras ran YOLOv11 for visual bird detection, and a spatio-temporal alignment step matched optical bounding-box tags to the unlabelled radar tracks. The point of this design was to close the labelling loop without paying ornithologists to annotate thousands of tracks by hand. We argued explicitly against hub-mounted cameras (slip-ring bandwidth limits, constantly shifting field of view) and nacelle-mounted cameras (dead corner obstructed by the tower itself); a tower-base ring of 4 to 8 PTZ units was the boring, deployable choice.

The classification layer underneath this design is the verified two-stage three-model pipeline from the previous sections: a binary LightGBM Gull detector feeding an ensemble of LightGBM, CatBoost, and XGBoost over the eight non-Gull classes, with per-class Platt/Isotonic calibration, rank-averaged outputs across models, and seed averaging for variance reduction. For deployment, the non-Gull stage carries an additional ecological-rarity weighting on the loss, so that misclassifying a protected raptor costs more than misclassifying a common gull. On top of that classifier sits an XAI surface intended for the wind farm operator: Grad-CAM heatmaps over YOLO frames to confirm an optical detection is a bird and not a turbine blade, SHAP attributions on the model's features to show why a track was classified the way it was, and counterfactual explanations for borderline cases. Behind that, a tiered Shutdown on Demand decision matrix: log-only for low-risk tracks, operator alert for medium, targeted curtailment for high-risk protected species at rotor height.

What the report did not do was claim a higher mAP. It asked a different question: could you put this in front of an operator who pays a financial penalty every time the model false-positives into an unnecessary shutdown? The honest answer was: not without the XAI surface, not without the cross-modal labelling loop to keep the model improving on real data, and not without an edge-processing story that discarded raw video to handle privacy and bandwidth. Writing those constraints down forced concessions the leaderboard never asked for.

The report scored 11th of 88. The modelling absorbed most of the five weeks; the report took a fraction of that time. The two tracks measured different things, and the asymmetry in returns was worth sitting with.

## 29th and 11th, and what I would do differently

Five weeks ended at a combined 29th of 88. The placement is honest, and the more useful material sits in the gaps in process rather than in the number.

The first gap was between my out-of-fold mAP and the score the model actually achieved on held-out private test. 0.7168 was the number I trusted at the end of the project, and the distance between that and the held-out reading was wider than the gain accumulated over the entire ensembling phase. The 10-fold StratifiedGroupKFold over `primary_observation_id` was not wrong, but it was optimistic. Future me would build the validation harness first, instrument the gap between OOF and a held-out probe submission as a first-class signal, and treat any change that improved OOF without improving the probe with corresponding suspicion. Pseudo-labelling was the same shape of problem, only visible enough that I caught it before it shipped to production.

The second gap was time allocation between the two tracks. The Implementation Track took roughly a tenth of the hours that went into modelling and finished 11th of 88. Marginal returns on the eighth feature group and the fourth ensemble member were small; marginal returns on a clearer page of the report were larger. Next time I would write the report alongside the modelling, not after it, and let the report's framing pull the modelling toward decisions an operator would actually care about: false-positive cost, edge deployability, explainability.

AI Cup 2026 was the first inter-university AI Cup in the Netherlands. The most honest postmortem is that I learned more in five weeks of doing it than I would have learned in three months of reading about how. That is the actual prize.

## All experiments tested

All scores are out-of-fold mAP on the training set under 10-fold StratifiedGroupKFold grouped by `primary_observation_id`. Bolded rows mark the configuration shipped to the final submission.

### Architecture and ensembling

| Configuration | OOF mAP | Delta |
|---|---|---|
| Single LightGBM (single-stage, 9-class) | 0.6550 | baseline |
| LightGBM + CatBoost, equal weights | 0.6652 | +0.0102 |
| Two-stage (Gull binary + 8-class ensemble) | 0.6698 | +0.0046 over single-stage |
| LightGBM + CatBoost + XGBoost, equal weights | 0.7087 | +0.0435 |
| + Per-class Platt/Isotonic calibration | 0.7097 | +0.0010 |
| + Tuned weights (w_lgb 0.45 / w_cb 0.25 / w_xgb 0.30) | 0.7119 | +0.0022 |
| + 5-seed averaging | 0.7112 | -0.0007 |
| **+ Rank averaging on top of all of the above** | **0.7168** | **+0.0049** |

### Oversampling experiments (on the two-stage + 3-model ensemble base)

| Method | OOF mAP | Notes |
|---|---|---|
| SMOTENC | 0.6999 | Baseline; SMOTE with categorical support |
| BorderlineSMOTE-1 | 0.7003 | Synthesises samples near decision boundaries |
| ADASYN | 0.7041 | Adaptive density-based; best single-method baseline |
| Trajectory augmentation (full jitter) | 0.7028 | Pre-feature-extraction synthesis: jitter + rotate + time-warp |
| Trajectory augmentation (0.5x jitter) | 0.7059 | Halved jitter; best Ducks AP (0.7531) |
| ADASYN + trajectory augmentation | 0.7000 | Methods interfere; collapses to baseline |
| ADASYN + pseudo-labelling (threshold 0.95) | 0.7148 | Leakage-inflated; not shipped |

### Stage 1 Gull threshold sweep

| Threshold | OOF mAP |
|---|---|
| 0.50 (default sigmoid) | 0.7041 |
| 0.70 | 0.7088 |
| **0.80** | **0.7105** |
| 0.85 | 0.7089 |

### Other experiments

| Experiment | Result |
|---|---|
| 17 RCS signature features (FFT, changepoints, histograms, moments) | No improvement, reverted |
| 1D CNN trajectory embeddings (32-dim, focal loss, 6-channel input) | No reliable improvement over handcrafted features |
| Combined KNMI + Open-Meteo weather | No improvement over Open-Meteo alone |
| KNMI alone (station 286) | Worse than Open-Meteo |
| Boost-weak class-targeted trajectory augmentation (multiplier 3, Cormorants/Waders/Geese) | Default in shipped pipeline |

