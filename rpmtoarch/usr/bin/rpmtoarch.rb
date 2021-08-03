#!/usr/bin/env ruby

require "fileutils"

class Package
  FILTERED_PARTS = %w[rpm x86_64]

  INSTALL_SECTIONS = %w[pre_install post_install pre_upgrade
                        post_upgrade pre_remove post_remove].freeze

  RPM_INSTALL_SECTIONS = %w[preinstall postinstall preupgrade
                            postupgrade preuninstall postuninstall].freeze

  attr_accessor :path_to_rpm, :pwd

  def initialize(path_to_rpm)
    @path_to_rpm = path_to_rpm
    @pwd = Dir.pwd
  end

  def run
    create_dir
    copy_rpm_file
    scripts = extract_scripts
    create_install_script(scripts)
    # Extract install scripts from rpm
    # Create install script
  end


  def extract_scripts
    Dir.chdir(File.expand_path('~') + "/rpmtoarch-working-directory/")
    rpm_scripts = %x(rpm -qp --scripts package.rpm)
    rpm_scripts = rpm_scripts.encode!("UTF-8", "UTF-8", invalid: :replace)
    Dir.chdir(pwd)
    parse_blocks(rpm_scripts)
  end

  def parse_blocks(rpm_scripts)
    current_block = nil
    rpm_scripts.split("\n").each_with_object({}) do |line, blocks|
      if section = find_section_in_line(line)
        blocks[section] = []
        current_block = blocks[section]
      elsif current_block
        current_block << line
      end
    end
  end

  def find_section_in_line(line)
    RPM_INSTALL_SECTIONS.each_with_index do |section, idx|
      return INSTALL_SECTIONS[idx] if line =~ /#{section}/
    end && nil
  end

  def create_install_script(scripts)
    File.open(install_script_path, "w") do |f|
      install_script = scripts.map do |function_name, code|
        <<-CODE.gsub(/\ {8}/, "")

        #{function_name}() {

        #{code.join("\n")}

        }

        CODE
      end.join("\n")
      f.write(install_script)
    end
  end

  def create_pkgbuild
    File.open(pkgbuild_path, "w") do |f|
      f.write(pkgbuild)
    end
  end

  def copy_rpm_file
    FileUtils.cp(rpm_basename, File.expand_path('~') + "/rpmtoarch-working-directory/package.rpm")
  end

  def create_dir
    Dir.mkdir(File.expand_path('~') + "/rpmtoarch-working-directory") unless Dir.exists?(package_name)
  end

  def rpm_basename
    @_rpm_basename ||= File.basename(@path_to_rpm)
  end

  def install_script_path
    File.expand_path('~') + "/rpmtoarch-working-directory/" + "package.install"
  end

  def pkgbuild_path
    File.expand_path('~') + "/rpmtoarch-working-directory/" + "PKGBUILD"
  end

  def package_name
    @_package_name ||= begin
      rpm_basename.split(".").reject do |p|
        FILTERED_PARTS.include?(p.to_s)
      end.join("_")
    end
  end
end

package = Package.new(ARGV[0])

puts "Basename: #{package.rpm_basename}"
puts "Package_name: #{package.package_name}"
puts "RUN: #{package.run}"

