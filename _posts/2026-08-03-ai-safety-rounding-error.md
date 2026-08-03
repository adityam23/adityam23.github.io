---
title: Is AI Safety Just a Rounding Error?
description: A bottom-up estimate of how much the frontier AI industry actually spends on safety, compared against other high-risk industries.
date: 2026-08-03
author: Aditya Menon
permalink: /projects/ai-safety/ai-safety-rounding-error/
repo_url: https://github.com/adityam23/ai-safety-playground
giscus_repo: adityam23/ai-safety-playground
giscus_repo_id: R_kgDOSceWUQ
giscus_category: Announcements
giscus_category_id: DIC_kwDOSceWUc4C8-me
---

# Is AI Safety Just a Rounding Error?

April 2026

> **Note (August 2026):** This estimate was done in April 2026. Since then there have been many more deals and the overall market has grown, but there has been no material change in the amount pledged for AI safety. One thing worth flagging: after Mythos, Anthropic said it would commit an additional $200M to AI safety, which is not counted here. Even if it were, total AI safety spend would still be under ~$1B — against AI capex measured in the trillions.

## The Premise

If you ask the people building frontier AI whether their work poses serious risks, you get a remarkably consistent answer: yes.

Dario Amodei, CEO of Anthropic, has publicly estimated a **25% probability of catastrophic outcomes** from advanced AI. Geoffrey Hinton left Google in 2023 specifically to warn about existential risk and went on to win a Nobel Prize. Yoshua Bengio, the most-cited AI researcher alive, now spends most of his time on safety work. In May 2024, **25 leading AI researchers, including two Turing Award winners and a Nobel laureate, published a consensus paper in *Science*** titled "Managing extreme AI risks amid rapid progress." [1] Their core recommendation:

> "Given the stakes, we call on major tech companies and public funders to allocate at least one-third of their AI R&D budget, comparable to their funding for AI capabilities, toward addressing the above R&D challenges and ensuring AI safety and ethical use."

The paper notes that today, **only 1–3% of AI publications are about safety**. That gap, between "one-third" and "1–3%", is the subject of this study.

We're going to look at how much money the frontier AI industry actually spends on safety, build a bottom-up estimate from the ground up, and compare it to what other high-risk industries spend. The conclusion is uncomfortable: AI safety spending is roughly **1,000 to 5,000 times smaller** than safety spending in nuclear power, aviation, or pharmaceuticals, relative to industry size.

## Resource Availability

Before asking whether AI labs spend enough on safety, it's worth establishing that they have the resources to spend more. Full-year 2025 results from the Big Four tech companies, all major players in AI, make this unambiguous. [2]–[13]

| Company | FY2025 Revenue | Net Income | CapEx | 2026 Guidance |
|---|---|---|---|---|
| Alphabet (Google) | $402.8B | $132.2B | $91.4B | $175–185B |
| Microsoft | $281.7B | $101.8B | $64.6B | >$120B |
| Meta | $201.0B | $83.3B | $72.2B | $115–135B |
| Amazon | $716.9B | $77.7B | $131.8B | ~$200B |
| **Combined** | **$1.6T** | **$397.7B** | **~$360B** | **~$620–640B** |

Microsoft became the **first software company to exceed $100 billion in annual net income** in FY2025. [14] NVIDIA, the picks-and-shovels supplier to this entire boom, reported $215.9 billion in FY2026 revenue and $193.7 billion in data centre revenue alone, up 68% year over year. Among the AI-native startups, **OpenAI reached a $20 billion annualised revenue run rate** by December 2025. **Anthropic hit $14 billion ARR** in February 2026 (climbing to ~$19 billion by March, per Bloomberg) and raised $30 billion at a $380 billion valuation. [15]

Capital expenditure across the Big Four hit roughly **$360 billion in 2025**, with 2026 guidance pointing towards **$620 billion or more**, primarily for AI infrastructure. [6][7][16] By contrast, the entire Apollo programme cost about $260 billion in inflation-adjusted dollars. The AI industry will spend more than that *every year* on compute, with most of it going toward making models more powerful.

The question isn't whether these companies could afford to spend more on safety. It's whether they choose to.

## Current Safety Expenditures

For headcount, the strongest data point comes from a **March 2026 Bloomberg/Glass.ai analysis** that crawled LinkedIn profiles and identified just **373 people working full-time on safety** across OpenAI, Google DeepMind, Anthropic, and xAI, about **3.4% of their combined workforce**. [17][18] Bloomberg's wry observation: those 373 people could fit on a single transatlantic flight.

We can supplement this with several other public sources:

- **DeepMind's AGI Safety & Alignment Team (ASAT)** has 30–50 researchers, per team lead Rohin Shah's posts on the Alignment Forum, growing roughly 37–39% per year. [19][20]

- **Anthropic's named safety teams** include Alignment Science (led by Jan Leike, ex-OpenAI), Interpretability (Chris Olah's team, with at least 18 members as of mid-2024), Frontier Red Team (~15 members under Logan Graham), Trust & Safety, Societal Impacts, and the Responsible Scaling Policy team led by co-founder Jared Kaplan.

- **OpenAI's Superalignment team** peaked at about 25 researchers before being disbanded in May 2024. Multiple subsequent safety teams (AGI Readiness, Mission Alignment) have also been disbanded. Today's distributed safety staff likely numbers 50–100 people. [21]–[23]

- **Meta** disbanded its Responsible AI team in November 2023 and now has a small Safety Alignment team within its Superintelligence Labs unit.

- **Microsoft** dissolved its Ethics & Society team entirely in March 2023 and largely outsources frontier safety research to OpenAI.

- **xAI's safety team** has been described by former employees as "effectively dissolved." Only one alignment-specific role is currently posted.

For compensation, we have verified data from **Levels.fyi and Glassdoor**: [24]–[28]

| Lab | Median Total Comp | Fully-Loaded Cost (1.5×) |
|---|---|---|
| OpenAI | $641K–$800K | $960K–$1,200K |
| Anthropic | $443K–$560K | $665K–$950K |
| Google DeepMind (US) | $375K–$650K | $560K–$975K |
| Google DeepMind (UK) | $200K–$350K | $300K–$525K |
| Meta AI | $350K–$470K | $525K–$700K |
| xAI | $400K–$660K | $600K–$990K |

The 1.5× multiplier accounts for payroll taxes (8–10%), benefits, office space (high in San Francisco and London), recruiting costs amortised over tenure and, critically, **compute allocation per researcher**, which Epoch AI estimates at $100K–$500K+ annually for researchers at frontier labs. [29][30] Importantly, **safety researchers are paid at parity with capabilities researchers**. There is no discount for safety work; OpenAI's Head of Preparedness role posted at $555K base salary plus equity. [28] Anthropic's interpretability research scientist roles list $315K–$560K base. [31] The safety/capability gap shows up in *headcount*, not in *pay*.

### 0.1 Lab-by-lab estimates

Multiplying headcount ranges by fully-loaded cost estimates:

| Lab | Safety Headcount | Annual Safety Spend |
|---|---|---|
| OpenAI | 50–100 | **$55–110M** |
| Anthropic | 60–120 | **$55–115M** |
| Google DeepMind | 80–150 | **$60–120M** |
| Meta AI | 15–25 | **$10–18M** |
| Microsoft | 25–40 | **$14–22M** |
| xAI | 5–8 | **$5–8M** |
| **Total** | **~235–443** | **~$200–390M** |

The central estimate across all six frontier labs is approximately **$280 million per year** on dedicated safety work. That number is what we'll carry forward through the rest of this analysis. Figure 1 highlights these estimates.

![AI Safety Researcher Compensation: Total Comp vs. Fully Loaded Cost](/assets/ai-safety/chart4_compensation.png)

**Figure 1:** A detailed breakdown of the annual cost per safety researcher at top AI labs, comparing standard total compensation (based on Levels.fyi and Glassdoor data) against "fully loaded" costs that include overhead multipliers. These fully loaded figures, which reach over $1 million at OpenAI, are the baseline metrics used to calculate the industry's bottom-up safety budgets.

### 0.2 Sanity check

It's worth pressure-testing this figure against an independent source. The EA Forum's "AI Safety Field Growth Analysis" (September 2025) [32] estimated **roughly $150–170 million in committed alignment research funding field-wide**, counting grants, philanthropic flows, and research budgets specifically tagged as alignment work, including non-profits, academic labs, and government institutions in addition to frontier labs.

The two numbers aren't contradictory. They measure different things:

- **Our $280M bottom-up estimate** counts everything labs spend on safety teams broadly defined, including red-teaming, interpretability, alignment science, trust & safety, societal impacts, and policy work.

- **The EA Forum's $150–170M** uses a stricter definition focused on technical alignment research narrowly defined, but spans the entire field (labs + non-profits + academia + government).

If anything, the fact that an independent field-wide analysis using stricter definitions arrives at an even smaller number is a sanity check that our $280M estimate is probably *generous*. The truth almost certainly sits somewhere between $150M and $400M annually for everything we'd reasonably call "AI safety spending" globally. For a story about an industry spending hundreds of billions per year, the difference between $150M and $400M is essentially noise.

## 1 Other Funding Sources

The frontier labs aren't the only players. There's a small but real ecosystem of organizations working on AI safety from the outside. [33]–[35]

### 1.1 Independent research organizations

- **METR** (~31 FTEs) conducts pre-deployment evaluations for OpenAI and Anthropic and publishes influential work on AI capability time horizons. Spun off from ARC Evals in late 2023.

- **Apollo Research** (~19 FTEs, London) focuses on deceptive alignment and "scheming" evaluations. Partners with both the UK and US AI safety institutes.

- **Redwood Research** (~10 FTEs) pioneered the "AI control" research agenda, techniques for staying safe even when models actively try to subvert safeguards.

- **MIRI** (~10–15 FTEs) pivoted from technical alignment to policy advocacy in 2024.

- **Goodfire** (~29 FTEs) and **Transluce** (~15 FTEs) are newer interpretability-focused startups.

- **Palisade Research** (~6 FTEs) works on AI security and offensive capability evaluations.

- **Epoch AI** (~25 FTEs) is the authoritative source on AI compute trends and forecasting.

### 1.2 University labs

- **Stanford Center for AI Safety** (~20 FTEs)

- **CHAI Berkeley** under Stuart Russell (~10–18 FTEs, ~$3M annually)

- **David Krueger's group at Cambridge** (~15 FTEs)

- **MIT Algorithmic Alignment Group** under Dylan Hadfield-Menell (~10 FTEs)

- **GovAI** at Oxford (~40 FTEs, focused on governance)

Notably, the **Future of Humanity Institute closed** in April 2024, ending one of the longest-running existential risk research programmes.

### 1.3 Government institutions

- The **UK AI Security Institute** (renamed from "Safety Institute" in early 2025) has ~75+ staff and £100 million in initial funding. It has tested 30+ frontier models and is led by Geoffrey Irving (ex-OpenAI, DeepMind).

- The **US AI Safety Institute** was renamed to "Center for AI Standards and Innovation" (CAISI) in June 2025 under the Trump administration, with a mandate shifting from safety evaluation to "pro-growth AI policies." It operates with approximately **$10 million**, the Center for AI Policy noted this is "nearly four times less than Tom Brady's annual salary at Fox."

### 1.4 Funding flows

- **Coefficient Giving** (formerly Open Philanthropy) is the largest funder, distributing ~$40–50M/year on AI safety from a cumulative $336M+ in grants. Launched its largest-ever technical AI safety RFP in early 2025 at $40M+.

- **Survival and Flourishing Fund** (Jaan Tallinn) gives ~$20–35M/year and allocated $34.3M in its 2025 round.

- **Schmidt Sciences** makes interpretability grants up to $5M each.

- The **Frontier Model Forum's AI Safety Fund**, pooled from Anthropic, Google, Microsoft, and OpenAI, has distributed roughly **$15 million total** since its 2023 launch.

- The combined philanthropic + government total is roughly **$150–200M/year**.

### 1.5 The full picture

Adding everything up:

| Source | Annual Spend |
|---|---|
| Frontier lab internal (bottom-up) | $200–390M |
| Government (UK AISI + US CAISI + others) | ~$100M |
| Philanthropy (Open Phil/Coefficient, SFF) | ~$93M |
| **Total global AI safety spending** | **~$400–600M/year** |

That's the full picture: **somewhere between $400 million and $600 million per year** spent globally on AI safety, broadly defined. Figure 2 shows the estimations. Against $360 billion in Big Four AI capex alone, that's **0.1% to 0.17%**. Against Gartner's projection of $2.52 trillion in total global AI spending for 2026, it's **0.016% to 0.024%**, about $1 in safety for every $4,000 to $6,000 in capability development. Figure 3 showcases the massive gap between AI spending for capabilities vs. safety. Note: the y-axis is logarithmic, to make the chart more readable.

![Where the ~$475M in Global AI Safety Funding Comes From (Annual Estimates, 2025–2026)](/assets/ai-safety/chart3_funding_sources.png)

**Figure 2:** This chart breaks down the estimated $475 million spent globally on AI safety annually, categorising funding into internal frontier lab budgets, government initiatives (such as the UK and US AI Safety Institutes), and philanthropic organizations. Notably, the combined global safety spend represents roughly 0.019% of the estimated $2.52 trillion spent on AI broadly.

![The Scale Mismatch: Capabilities vs. Safety Spending (Log Scale, Each Gridline = 10x More Money)](/assets/ai-safety/chart5_oom_gap.png)

**Figure 3:** Displayed on a logarithmic scale where each gridline represents a 10x increase, this chart illustrates the massive financial gap between AI capabilities and safety. It highlights how the estimated $280 million spent internally by AI labs on safety is dwarfed not only by established federal safety budgets (like the FDA and FAA) but also by the cost of a single frontier model training run ($1 billion) and total global AI spending ($2.5 trillion).

## 2 The Bengio benchmark

Recall the central recommendation from Bengio et al. in *Science*: at least **one-third** of AI R&D budgets should go to safety. Apply that to actual numbers.

- Alphabet's R&D budget in 2025 was **$61.1 billion**. One-third would be ~$20 billion.

- The Big Four's combined ~$360 billion in capex. One-third would be ~$120 billion.

- The frontier AI industry as a whole. One-third would be hundreds of billions.

The actual figure, somewhere between $400M and $600M, is roughly **200 to 300 times smaller** than what one company alone (Alphabet) would need to spend to hit Bengio's benchmark. From a workforce perspective, the gap is similarly stark: the Bengio paper's spirit is that roughly one in three AI researchers should be working on safety. Our data shows the actual figure is **3.4%** at the four labs Bloomberg/Glass.ai measured, about ten times below the benchmark, even for the labs taking safety most seriously. Figure 4 showcases this discrepancy.

![How Much Do Frontier AI Labs Actually Spend on Safety?](/assets/ai-safety/chart1_lab_bottom_up.png)

**Figure 4:** This figure displays estimated annual safety spending at major frontier AI labs, including OpenAI, Anthropic, Google DeepMind, Meta AI, Microsoft, and xAI, calculated using headcount and fully loaded compensation. A companion chart illustrates that safety staff make up a very small fraction of the total workforce at these labs (ranging from 0.01% to 3.3%), falling drastically short of the 33% target proposed by Bengio et al.

## 3 Case Study: Anthropic

If any frontier lab takes safety seriously, it's Anthropic. The company was founded in 2021 by Dario and Daniela Amodei along with five other senior OpenAI researchers who left over safety concerns. Its founding narrative, public commitments, and team structure are all built around the premise that frontier AI is dangerous and needs careful handling.

Anthropic's safety apparatus is the most public and well-documented in the industry:

- The **Frontier Red Team** (~15 members under Logan Graham, within the Policy organisation led by co-founder Jack Clark) stress-tests Anthropic's most advanced models for cybersecurity, biosecurity, and autonomous capabilities. Its findings directly inform AI Safety Level (ASL) determinations under Anthropic's Responsible Scaling Policy. The team has partnered with the NNSA/DOE for nuclear risk evaluation in classified environments and with Mozilla, where it discovered 14 high-severity bugs and 22 CVEs.

- The **Alignment Science team**, co-led by **Jan Leike** (who left OpenAI's Superalignment team in May 2024), publishes work on scalable oversight, AI control, and model organisms of misalignment. Key papers include "Sleeper Agents" and "Alignment Faking in Large Language Models" (December 2024), the first empirical demonstration of an AI model strategically pretending to be aligned during training.

- **Chris Olah's Interpretability team** has produced what many consider the field's most important empirical results, including "Towards Monosemanticity" (2023), "Scaling Monosemanticity" (May 2024), and "Signs of Introspection in Large Language Models" (October 2025). Dario Amodei's April 2025 essay "The Urgency of Interpretability" argued that interpretability could be solved before models become overwhelmingly powerful, and that this is essential.

- **Constitutional AI**, published in December 2022, is Anthropic's framework for training models to follow a published set of principles rather than relying on opaque human feedback. The constitution is publicly available at `anthropic.com/constitution`.

- **Constitutional Classifiers** (February 2025) withstood **3,000+ hours of red teaming** with no universal jailbreak found.

- The **Responsible Scaling Policy**, with Jared Kaplan as Responsible Scaling Officer, defines the safety conditions Anthropic commits to meeting before training increasingly capable models.

- Most recently, the Frontier Red Team's testing of **Claude Mythos Preview** (April 2026) led Anthropic to **withhold the model from public release** entirely, instead distributing it to ~50 organizations through "Project Glasswing" with $100M in usage credits restricted to defensive cybersecurity work.

This is, by some distance, the most substantive safety apparatus at any frontier lab. And yet:

**Anthropic's safety staff still represent only ~3.3% of its workforce**, about ten times below the Bengio benchmark. Anthropic has roughly **60–120 people** working on safety out of ~2,300 employees. At a fully-loaded cost of ~$800K per researcher, the company spends an estimated **$55–115M per year** on dedicated safety work. That's against ~$14B in annualised revenue (February 2026) and tens of billions in compute commitments.

**Anthropic's entire safety budget is roughly the same size as a single large training run.**

And here's the harder part: **Anthropic doesn't have the money the tech giants do.** It generated ~$14B in annualised revenue in early 2026 against an estimated ~$2.5–3B in compute costs alone, and is reportedly burning cash. Compare this to Alphabet, which made $132 billion in net *profit* in 2025. If Anthropic devoted *all* of its revenue to safety, it would still spend less than 12% of what Alphabet's R&D budget alone would represent under the Bengio benchmark.

The lab leading on safety is also the lab with the least money to spend on it. This is structurally bad. The companies with the deepest pockets, Google, Microsoft, Meta, Amazon, are the ones whose safety investments are weakest in proportion to their resources.

**It gets worse.** In February 2026, Anthropic published RSP v3.0, which **removed the unconditional commitment to pause training** if safety measures proved inadequate, replacing binding pledges with a nonbinding "Frontier Safety Roadmap." TIME and CNN both reported it as "Anthropic ditches its core safety promise." Anthropic justified the change by citing competitive pressure: "It wouldn't actually help anyone for us to stop training AI models" while "competitors are blazing ahead." Even the safety leader is being pulled towards the bottom.

## 4 Comparative Industry Safety Spend

The AI industry's safety spending ratio looks anomalous against every mature high-risk industry. [36]–[47] The numbers are not even close. Figure 5 showcases the stark divide.

| Industry | Safety Spending | Source |
|---|---|---|
| **Medical Devices (Class III)** | 59–80% of dev. costs | FDA clinical study data |
| **Nuclear Power** | ~30–40% of total costs | Amer. Action Forum / NEI |
| **Pharmaceuticals** | 21–25% of revenue | CBO / PhRMA |
| **Aviation (Airlines)** | 11–25% of operating costs | IATA 2025 |
| **Financial Services** | ~19% of revenue | Model Office, CSBS |
| **Oil & Gas** | 5–10% of operating costs | Industry estimates |
| **Automotive** | 3–5% of revenue | Industry estimates |
| **Frontier AI (bottom-up)** | ~0.04% of capex | This analysis |

Two comparisons deserve emphasis:

**Nuclear power.** A 2015 American Action Forum analysis using Nuclear Energy Institute and Electric Utility Cost Group filings found U.S. nuclear plants spent approximately **32% of total capital expenditures on regulatory compliance**, almost exactly the Bengio one-third recommendation. The NRC's FY2025 budget of ~$944 million is essentially all safety overhead, recovered through industry fees averaging $60 million per plant per year. Capital costs represent ~60% of nuclear's levelised cost of energy, with safety as a primary driver. **Nuclear power, the industry famous for being prohibitively expensive due to regulation, spends a thousand times more on safety per dollar of activity than frontier AI.**

**Aviation.** IATA's 2025 Maintenance Cost Executive Commentary reports that airlines spent **$93.9 billion globally** on maintenance, repair, and overhaul in FY2023, about 11% of operating costs, virtually all of it safety-mandated. Adding the FAA's $23.1 billion budget and internal airline safety departments brings total industry safety spending to roughly 15% of revenue. The aviation industry has reached a point where commercial flying is statistically safer than driving to the airport. It got there through decades of mandatory, expensive, unglamorous safety investment.

**Pharmaceuticals.** Perhaps the most apt comparison. PhRMA members spent **21% of combined global revenues on R&D in 2023**, with the CBO estimating ~25% of net revenues. The crucial point is that the vast majority of pharma R&D *is* safety testing, clinical trials (Phases I–III) represent 70–80% of R&D costs and are fundamentally about demonstrating safety and efficacy to regulators. If we were to apply the pharma model to AI, safety testing would consume something like a quarter of all industry revenue. The actual figure for AI is closer to 1/2000th of that.

Every industry on that chart got its safety culture the hard way, through disasters, deaths, public outcry, and the regulation that followed. Boeing's 737 MAX crashes, Three Mile Island, Vioxx, Volkswagen's emissions cheating: each one led to billions in additional safety spending and decades of process changes. The question for AI is whether we can get ahead of that curve.

![Safety Spending as Share of Industry Costs: AI Labs vs. Established High-Risk Industries](/assets/ai-safety/chart2_industry_comparison.png)

**Figure 5:** A comparison of safety budgets across various sectors, showing that established high-risk industries invest heavily in safety as a percentage of total costs (e.g., Medical Devices at 59% to 80% and Nuclear Power at 30% to 40%). In stark contrast, frontier AI labs currently allocate an estimated 0.01% to 0.04% of their budgets to safety, amounting to 1,000 to 5,000 times less relative spending than the nuclear industry.

## 5 Moving the Wrong Direction

What's most concerning isn't the current spending level, it's the direction.

Since mid-2024, the visible signal has been **shrinking safety commitments**, not expanding ones:

- **OpenAI** disbanded the Superalignment team (May 2024), the AGI Readiness team (October 2024), and the Mission Alignment team (February 2026), three separate safety teams in less than two years. Reporting indicates more than half of OpenAI's safety-focused researchers have departed.

- **Anthropic** dropped its binding Responsible Scaling Policy commitments in February 2026.

- **Meta** disbanded its Responsible AI team in November 2023.

- **Microsoft** dissolved its Ethics & Society team in March 2023.

- **xAI's** safety team has been described by former employees as "effectively dissolved."

On the regulatory side, the picture is similarly fragmenting:

- The Trump administration **rescinded Biden's AI safety executive order** on its first day (January 20, 2025), then renamed the US AISI to CAISI with a "pro-growth" mandate.

- The Paris AI Action Summit in February 2025 was rebranded from "safety" to "action", and the US and UK refused to sign the final declaration.

- The EU AI Act is moving forward, but enforcement is contested.

- California's SB 53 (signed September 2025) is a scaled-back successor to the much stronger SB 1047 that Governor Newsom vetoed in 2024.

The Future of Life Institute's 2025 AI Safety Index graded the seven leading AI companies across 33 indicators. **None scored above D in existential safety planning** despite all of them claiming AGI within the decade. Anthropic was the highest at C+ (2.64/5). Meta was lowest at D (1.06).

Capability teams at the frontier labs are growing **30–40% per year**. Safety teams are growing **21–24% per year**. The gap is widening, not closing.

## 6 Conclusion

The AI industry isn't underspending on safety because it can't afford to spend more. Microsoft made a hundred billion dollars in profit last year. Alphabet is preparing to spend $175 billion on capex in 2026 alone. The combined Big Four will spend more on AI infrastructure this year than the entire Apollo programme cost in inflation-adjusted dollars.

The industry is underspending on safety because it has chosen to prioritise speed. Every other safety-critical industry on the chart above made the opposite choice, usually after disasters forced their hand. Nuclear power spent decades and trillions of dollars learning to manage radioactive material. Aviation built the most sophisticated safety culture in human history through painful, mandatory investment. Pharmaceutical companies routinely spend years and hundreds of millions of dollars proving that a single drug is safe before they're allowed to sell it.

Frontier AI has none of those guardrails. The labs face commercial pressure to move fast, no binding safety regulation, and no mandatory minimum spending on safety research. The result is an industry building what its own leaders call potentially the most consequential technology in human history, while spending less than 0.1% of its budget making sure it goes well.

The Bengio benchmark says one-third of R&D should go to safety. The actual figure is somewhere between 0.01% and 0.1%. Even the lab leading on safety, Anthropic, is at about 3%, ten times below the benchmark, and now backing away from its own binding commitments under competitive pressure.

This is a priorities problem. And until it changes, either through internal commitments that actually hold under pressure, or through external regulation with teeth, the people building the most consequential technology of our time will continue to spend less making it safe than it costs to train a single model.

## References

[1] Yoshua Bengio, Geoffrey Hinton, Andrew Yao, Dawn Song, Pieter Abbeel, Trevor Darrell, Yuval Noah Harari, Ya-Qin Zhang, Lan Xue, Shai Shalev-Shwartz, Gillian Hadfield, Jeff Clune, Tegan Maharaj, Frank Hutter, Atılım Güneş Baydin, Sheila McIlraith, Qiqi Gao, Ashwin Acharya, David Krueger, Anca Dragan, Philip Torr, Stuart Russell, Daniel Kahneman, Jan Brauner, and Sören Mindermann. Managing extreme AI risks amid rapid progress. *Science*, 384(6698):842–845, May 2024. https://www.science.org/doi/10.1126/science.adn0117

[2] Larry Dignan. Alphabet plots massive capex increase for 2026 | constellation research. https://www.constellationr.com/insights/news/alphabet-plots-massive-capex-increase-2026, 2026. Constellationr.com.

[3] Macrotrends. Alphabet research and development expenses 2010-2021 | googl. https://www.macrotrends.net/stocks/charts/GOOGL/alphabet/research-development-expenses, 2025. www.macrotrends.net.

[4] META) Reality. Facebook (meta) reality labs lost $19.193 billion in 2025. https://www.shacknews.com/article/147618/facebook-meta-reality-labs-fy25-losses, Jan 2026. Shacknews.

[5] Jay's Insight. Microsoft's 2025 capex plan highlights data center demands. https://www.ainvest.com/news/microsoft-s-2025-capex-plan-highlights-data-center-demands-250110100290614dbf46d8fa/, Jan 2025. Ainvest.

[6] Alphabet Inc. Alphabet announces fourth quarter and fiscal year 2025 results. https://www.sec.gov/Archives/edgar/data/0001652044/000165204426000012/googexhibit991q42025.htm, February 2026. SEC Form 8-K, Exhibit 99.1, filed February 4, 2026.

[7] Meta Platforms, Inc. Meta reports fourth quarter and full year 2025 results. https://investor.atmeta.com/investor-news/press-release-details/2026/Meta-Reports-Fourth-Quarter-and-Full-Year-2025-Results/default.aspx. January 2026. SEC Form 8-K filed January 28, 2026.

[8] Alphabet sec exhibit 99.1 q4 2025. https://www.sec.gov/Archives/edgar/data/1652044/000165204426000012/googexhibit991q42025.htm, 2025. Sec.gov.

[9] Microsoft sec form ex-99.1. https://www.sec.gov/Archives/edgar/data/789019/000095017025100226/msft-ex99_1.htm, 2025. Sec.gov.

[10] Meta sec exhibit 99.1. https://www.sec.gov/Archives/edgar/data/1326801/000162828026003832/meta-12312025xexhibit991.htm, 2025. Sec.gov.

[11] Microsoft earnings fy 2025 q2. https://www.microsoft.com/en-us/investor/events/fy-2025/earnings-fy-2025-q2, 2025. Microsoft.com.

[12] Amazon sec exhibit 99.1. https://www.sec.gov/Archives/edgar/data/1018724/000101872426000002/amzn-20251231xex991.htm, 2026. Sec.gov.

[13] Meta q4 earnings live. https://www.tomsguide.com/news/live/meta-q4-earnings-live-jan-2026, Jan 2026. Tom's Guide.

[14] Mike Thrift. Microsoft fy2025 earnings: The $101b profit machine betting everything on ai infrastructure. https://beancount.io/blog/2026/03/23/microsoft-fy2025-earnings-analysis, Mar 2026. Beancount.io.

[15] Billy Perrigo. Exclusive: Anthropic drops flagship safety pledge. https://time.com/7380854/exclusive-anthropic-drops-flagship-safety-pledge/, February 2026. TIME Magazine.

[16] Amazon posts record results. https://www.publishersweekly.com/pw/by-topic/industry-news/financial-reporting/article/99649-amazon-posts-record-results.html, 2026. PublishersWeekly.com.

[17] Parmy Olson. AI companies talk safety. headcount of safety teams tells a different story. https://www.bloomberg.com/opinion/articles/2026-03-18/ai-companies-talk-safety-headcount-of-safety-teams-tells-a-different-story, March 2026. Bloomberg Opinion.

[18] Parmy Olson. Anthropic, openai talk safety. their headcounts don't. https://www.bloomberg.com/opinion/articles/2026-03-18/ai-companies-talk-safety-headcount-of-safety-teams-tells-a-different-story, Mar 2026. Bloomberg.com.

[19] Rohin Shah. AGI safety and alignment at Google DeepMind: A summary of recent work. https://deepmindsafetyresearch.medium.com/agi-safety-and-alignment-at-google-deepmind-a-summary-of-recent-work-8e600aca582a, 2024.

[20] Rohin Shah, Seb Farquhar, and Anca Dragan. Agi safety and alignment at google deepmind: A summary of recent work. https://www.alignmentforum.org/posts/79BPxvSsjzBkiSyTq/agi-safety-and-alignment-at-google-deepmind-a-summary-of, Aug 2024. Alignmentforum.org.

[21] Jeremy Kahn. OpenAI promised 20% of its computing power to combat the most dangerous kind of AI—but never delivered, sources say. https://fortune.com/2024/05/21/openai-superalignment-20-compute-commitment-never-fulfilled-sutskever-leike-altman-brockman-murati/, May 2024. Fortune Magazine.

[22] Hayden Field. Openai disbands another safety team, as head advisor for "agi readiness" resigns. https://www.cnbc.com/2024/10/24/openai-disbands-agi-readiness.html, Oct 2024. CNBC.

[23] Markus Kasanmascheff. Openai disbands its mission alignment team after just 16 months. https://winbuzzer.com/2026/02/12/openai-disbanded-mission-alignment-team-16-months-xcxwbn/, Feb 2026. WinBuzzer.

[24] Levels.fyi. Salary data for AI research engineers and scientists. https://www.levels.fyi/, 2026.

[25] Levels.fyi: Openai salaries. https://www.levels.fyi/companies/openai/salaries. Levels.fyi.

[26] Levels.fyi: Google research salaries. https://www.levels.fyi/companies/google/salaries/research, 2026. Levels.fyi.

[27] Levels.fyi: Anthropic salaries. https://www.levels.fyi/companies/anthropic/salaries, 2025. Levels.fyi.

[28] Sherin Shibu. Openai is prepared to pay someone $555,000 — plus equity — for this "stressful job". https://www.entrepreneur.com/business-news/openai-is-prepared-to-pay-someone-555000-plus-equity-for-this-stressful-job, Dec 2025. Entrepreneur.

[29] Ai companies staff reports. https://epoch.ai/data/ai_companies_staff_reports.csv, 2017. Epoch.ai.

[30] Fully loaded cost of a us employee. https://www.glencoyne.com/guides/fully-loaded-cost-us-employee, 2025. Glencoyne.com.

[31] Anthropic salary overview. https://www.nahc.io/blog/anthropic-salary-overview-how-much-do-employees-get-paid, 2024. Nahc.io.

[32] Stephen McAleese. Ai safety field growth analysis 2025. https://forum.effectivealtruism.org/posts/7YDyziQxkWxbGmF3u/ai-safety-field-growth-analysis-2025, Sep 2025. Effectivealtruism.org.

[33] Stephen McAleese. An overview of the ai safety funding situation. https://www.lesswrong.com/posts/WGpFFJo2uFe5ssgEb/an-overview-of-the-ai-safety-funding-situation, Jul 2023. Lesswrong.com.

[34] Frontier Model Forum. Announcement of new ai safety fund grantees - frontier model forum. https://www.frontiermodelforum.org/updates/announcement-of-new-ai-safety-fund-grantees/, Dec 2025. Frontier Model Forum.

[35] 10 funders 500 million targeting ai and humanity. https://thenonprofittimes.com/npt_articles/10-funders-500-million-targeting-ai-and-humanity/, Oct 2025. The NonProfit Times.

[36] David Austin and Tamara Hayford. Research and development in the pharmaceutical industry. https://www.cbo.gov/publication/57126, Apr 2021. Congressional Budget Office.

[37] dwillis and dwillis. The high price of non-compliance in financial services. https://fintech.global/2025/03/31/the-high-price-of-non-compliance-in-financial-services/, Mar 2025. FinTech Global.

[38] Walt Williams. Csbs: Data show regulatory burden falls hardest on community banks. https://bankingjournal.aba.com/2025/11/csbs-data-show-regulatory-burden-falls-hardest-on-community-banks/, Nov 2025. ABA Banking Journal.

[39] World Nuclear Association. Economics of nuclear power - world nuclear association. https://world-nuclear.org/information-library/economic-aspects/economics-of-nuclear-power, Sep 2023. world-nuclear.org.

[40] What does the us government do? faa. https://usafacts.org/explainers/what-does-the-us-government-do/subagency/federal-aviation-administration/, 2024. USAFacts.

[41] Cost of compliance: Regulatory productivity. https://www.deloitte.com/us/en/services/consulting/articles/cost-of-compliance-regulatory-productivity.html, 2025. Deloitte.

[42] Nrc finalizes fy 2025 fee rule. https://www.morganlewis.com/blogs/upandatom/2025/07/nrc-finalizes-fy-2025-fee-rule-with-significant-break-for-advanced-reactor-applicants, Jul 2025. Morganlewis.com.

[43] Every crs report r48585. https://www.everycrsreport.com/reports/R48585.html, Jul 2025. Everycrsreport.com.

[44] Nrc cuts 50 percent off for advanced reactor applicants. https://www.ans.org/news/2025-06-25/article-7136/nrc-cuts-50-percent-off-for-advanced-reactor-applicants/, 2026. Ans.org.

[45] Putting nuclear regulatory costs in context. https://www.americanactionforum.org/research/putting-nuclear-regulatory-costs-context/. AAF.

[46] Fy2023 mcx report. https://www.iata.org/contentassets/8437020db31a4717b70677d9b06b1a45/fy2023-mcx-report_public.pdf. IATA.

[47] Research and development expenditure of the us pharmaceutical industry. https://www.statista.com/statistics/265085/research-and-development-expenditure-us-pharmaceutical-industry/. Statista.
