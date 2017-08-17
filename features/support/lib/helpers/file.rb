module FileHelper

  Locator = 'div.pd-droptarget div.table-responsive tbody tr'
  PATH    = FilesDirectory

  extend self

  def files
    Dir["#{PATH}/*"]
  end

  def has_file? name
    files.grep(/#{name}/).any?
  end

  def clear_files
    FileUtils.rm_f(files)
  end

  def displayed_count
    return Finder.every({locator: Locator}).length
  end

end