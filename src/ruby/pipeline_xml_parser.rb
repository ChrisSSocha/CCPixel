require 'nokogiri'

class PipelineXMLParser

  def get_projects(xml_document)
    parse(xml_document)
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
      last_build_status = project_xml.attr(Constants::LAST_BUILD_STATUS_ATTR)
      last_build_label = project_xml.attr(Constants::LAST_BUILD_LABEL_ATTR)
      last_build_time = project_xml.attr(Constants::LAST_BUILD_TIME_ATTR)
      next_build_time = project_xml.attr(Constants::NEXT_BUILD_TIME_ATTR)
      web_url = project_xml.attr(Constants::WEB_URL_ATTR)

      Project::Builder.new(name, activity)
                      .last_build_status(last_build_status)
                      .last_build_label(last_build_label)
                      .last_build_time(last_build_time)
                      .next_build_time(next_build_time)
                      .web_url(web_url)
                      .build()
    end

end