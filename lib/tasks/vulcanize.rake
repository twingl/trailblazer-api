desc <<-DESC
Generate "public/vulcanized.html" by running vulcanize over all assets
used in the application tb-app
DESC
task :vulcanize do
  `./node_modules/vulcanize/bin/vulcanize ./public/assets/components/tb-app/tb-app.html -o ./public/vulcanized.html --inline`
end

