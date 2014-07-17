#!/usr/bin/env ruby

# run committed files against the ruby style guide.
require 'open3'
stdout, stderr, status = Open3.capture3("git diff --name-only --cached | grep -E '#{%w[rb rake].map{|ext| '\.' + ext}.join('|')}' ")
modified_files = stdout.split(/\n/)
if modified_files.count > 0
  $stdout.puts("Code conventions: running files against rubocop (https://github.com/bbatsov/rubocop/):")
  $stdout.puts(modified_files.join("\n "))
  stdout, stderr, status = Open3.capture3("rubocop #{modified_files.join(' ')}")
  if status.exitstatus != 0
    $stdout.puts(stdout)
    $stdout.puts("*******************************************************************************************")
    $stdout.puts("The files you committed need cleanup! Many of the warnings are probably old and not yours.")
    $stdout.puts("We need your help with cleaning. If you think some errors should be ignored, edit .rubocop.yml")
    $stdout.puts("You might also try running 'rubocop $your_file --auto-correct', but review the changes!")
    $stdout.puts("*******************************************************************************************")
    exit 1
  else
    $stdout.puts("Files passed Rubocop!")
    exit 0
  end
end

# if you want to add your own pre-commit logic, consider what would happen if one or many checks worked or failed,
# i.e. a sub_routines: [{ name: foo, status: some_value },...]
