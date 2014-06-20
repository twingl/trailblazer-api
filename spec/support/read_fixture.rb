# Read a fixture from a file (located in a sub-path of #
# `#{Rails.root}/spec/fixtures`)
#
# Returns a string if the file is found.
#
# If the file isn't found an exception is raised or the optionally specified
# value is returned
def read_fixture(file, value_if_file_not_found = false)
  begin
    file.sub!('?', '_') # we have to replace this character on Windows machine
    File.read(File.join(APP_ROOT, 'spec', 'fixtures', file))
  rescue Errno::ENOENT => e
    raise e if value_if_file_not_found == false
    value_if_file_not_found
  end
end
