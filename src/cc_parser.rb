require 'nokogiri'

class CCParser

  def initialize(ccInput)
    @ccInput = ccInput
  end

  def getProjects
    xml = @ccInput.fetch()
    parse(xml)
  end

  private

    module Constants
      PROJECT_XPATH = "//Project"
      NAME_ATTR = "name"
      ACTIVITY_ATTR = "activity"
      LAST_BUILD_STATUS_ATTR = "lastBuildStatus"
      LAST_BUILD_LABEL_ATTR = "lastBuildLabel"
      LAST_BUILD_TIME_ATTR = "lastBuildTime"
      NEXT_BUILD_TIME_ATTR = "nextBuildTime"
      WEB_URL_ATTR = "webUrl"
    end

    def parse(xml)
      projects = Array.new

      doc  = Nokogiri::XML(xml)
      xml_projects = doc.xpath(Constants::PROJECT_XPATH)

      xml_projects.each {|project_xml|
        projects.push(parse_project(project_xml))
      }

      projects
    end

    def parse_project(project_xml)
      name = project_xml.attr(Constants::NAME_ATTR)
      activity = project_xml.attr(Constants::ACTIVITY_ATTR)
      lastBuildStatus = project_xml.attr(Constants::LAST_BUILD_STATUS_ATTR)
      lastBuildLabel = project_xml.attr(Constants::LAST_BUILD_LABEL_ATTR)
      lastBuildTime = project_xml.attr(Constants::LAST_BUILD_TIME_ATTR)
      nextBuildTime = project_xml.attr(Constants::NEXT_BUILD_TIME_ATTR)
      webUrl = project_xml.attr(Constants::WEB_URL_ATTR)

      Project::Builder.new(name, activity)
                      .lastBuildStatus(lastBuildStatus)
                      .lastBuildLabel(lastBuildLabel)
                      .lastBuildTime(lastBuildTime)
                      .nextBuildTime(nextBuildTime)
                      .webUrl(webUrl)
                      .build()
    end

end