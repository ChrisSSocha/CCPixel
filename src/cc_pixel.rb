require_relative 'model/project'

class CCPixel

  def initialize(output)
    @output = output
  end

  def process(projects)

    building = false;
    failed = false;

    projects.each{|project|
      if project.isBuilding?
        building = true
      end

      unless project.isSuccessful?
        failed = true
      end
    }

    if failed
      if building
        @output.fail_building()
      else
        @output.fail()
      end
    else
      if building
        @output.success_building()
      else
        @output.success()
      end
    end

  end

  private

end