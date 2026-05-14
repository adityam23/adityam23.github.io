#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'
require 'date'
require 'tmpdir'

POSTS_DIR = '_posts'

Dir.mktmpdir do |tmp|
  # Start from a clean _posts each build
  FileUtils.rm_rf(POSTS_DIR)
  FileUtils.mkdir_p(POSTS_DIR)

  projects = YAML.load_file('projects.yml').fetch('projects')

  projects.each do |project|
    repo   = project.fetch('repo')
    branch = project['branch'] || 'main'
    slug   = repo.split('/').last.downcase

    puts "→ #{repo} @ #{branch}"
    clone_dir = File.join(tmp, slug)

    ok = system('git', 'clone', '--depth=1', '--branch', branch, '--quiet',
                "https://github.com/#{repo}.git", clone_dir)
    unless ok
      warn "  clone failed — skipping"
      next
    end

    src = File.join(clone_dir, 'portfolio', 'post.md')
    unless File.exist?(src)
      warn "  no portfolio/post.md — skipping"
      next
    end

    content = File.read(src)
    date = content[/^date:\s*([\d-]{10})/, 1] || Date.today.strftime('%Y-%m-%d')

    dest = File.join(POSTS_DIR, "#{date}-#{slug}.md")
    File.write(dest, content)
    puts "  wrote #{dest}"
  end

  puts "\nAggregated #{Dir.glob("#{POSTS_DIR}/*.md").length} posts."
end
