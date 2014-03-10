require 'nokogiri'

class CCTray

  def initialize(ccFetch)
    @ccFetch = ccFetch
  end

  def getProjects
    xml = @ccFetch.fetch()
    parse(xml)
  end

  private

    def parse(xml)
      projects = Array.new

      doc  = Nokogiri::XML(xml)
      xml_projects = doc.xpath("//Project")

      xml_projects.each {|project_xml|

        name = project_xml.attr("name")
        activity = project_xml.attr("activity")
        lastBuildStatus = project_xml.attr("lastBuildStatus")
        lastBuildLabel = project_xml.attr("lastBuildLabel")
        lastBuildTime = project_xml.attr("lastBuildTime")
        nextBuildTime = project_xml.attr("nextBuildTime")
        webUrl = project_xml.attr("webUrl")

        project = Project::Builder.new(name, activity)
                                  .lastBuildStatus(lastBuildStatus)
                                  .lastBuildLabel(lastBuildLabel)
                                  .lastBuildTime(lastBuildTime)
                                  .nextBuildTime(nextBuildTime)
                                  .webUrl(webUrl)
                                  .build()

        projects.push(project)
      }

      projects
    end

end