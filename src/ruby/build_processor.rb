require_relative 'model/project'
require_relative 'pipeline_web_resource'
require_relative 'pipeline_xml_parser'

class BuildProcessor

  def initialize(input, parser, output)
    @input = input
    @parser = parser
    @output = output
  end

  def run()
    xml_document = @input.fetch
    projects = @parser.get_projects(xml_document)
    process(projects)
  end

  private

    def process(projects)

      if projects.empty?
        @output.off
      else
        building = is_building?(projects)
        failed = is_failure?(projects)

        if failed
          if building
            @output.fail_building
          else
            @output.fail
          end
        else
          if building
            @output.success_building
          else
            @output.success
          end
        end
      end

    end

    def is_building?(projects)
      building = false
      projects.each{|project|
        if project.is_building?
          building = true
        end
      }
      return building
    end

    def is_failure?(projects)
      failure = false
      projects.each{|project|
        unless project.is_successful?
          failure = true
        end
      }
      return failure
    end


  end