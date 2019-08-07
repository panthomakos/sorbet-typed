#!/usr/bin/env ruby

gems = Dir.glob("lib/*")

results =
  gems.flat_map do |dir|
    versions = Dir.glob(dir + '/*').map { |f| File.basename(f) }


    versions.map do |version|
      next if version == "test"
      puts "testing #{dir} #{version}"
      dirs = ["#{dir}/#{version}"]
      dirs << "#{dir}/all" if versions.include?('all')
      dirs = dirs.uniq.map { |d| "\"#{d}\"" }.join(' ')
      system("srb tc --error-black-list 5002 #{dirs}")
    end
  end

exit results.compact.all?
