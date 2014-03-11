require_relative 'model/project'

class CCPixel

  def initialize(output)
    @output = output
  end

  def process(projects)

    if(projects.empty?)
      @output.off
    else
      building = isBuilding?(projects)
      failed = isFailure?(projects)

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

  end

  private

    def isBuilding?(projects)
      building = false
      projects.each{|project|
        if project.isBuilding?
          building = true
        end
      }
      return building
    end

    def isFailure?(projects)
      failure = false
      projects.each{|project|
        unless project.isSuccessful?
          failure = true
        end
      }
      return failure
    end


  end