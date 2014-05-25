require 'yaml'

require_relative "../src/ruby/model/project"

module TestConstants

  module Project
    NAME_1 = "HelloWorld"
    NAME_2 = "GoodbyeWorld"

    ACTIVITY = ::Project::Constants::Activity::SLEEPING
    LAST_BUILD_STATUS = ::Project::Constants::LastBuildStatus::SUCCESS
    LAST_BUILD_LABEL = "13"
    LAST_BUILD_TIME = "2005-09-15T17:33:07.6447696+01:00"
    NEXT_BUILD_TIME = "2005-10-04T14:31:51.7799600+01:00"
    WEB_URL = "http://example/"

    def build_project(name = NAME_1, activity = ACTIVITY, last_build_status = LAST_BUILD_STATUS)
      ::Project::Builder.new(name, activity)
      .last_build_status(last_build_status)
      .last_build_label(LAST_BUILD_LABEL)
      .last_build_time(LAST_BUILD_TIME)
      .next_build_time(NEXT_BUILD_TIME)
      .web_url(WEB_URL).build()
    end

    module_function :build_project

    SAMPLE_PROJECT_1 = build_project(NAME_1)
    SAMPLE_PROJECT_2 = build_project(NAME_2)

    SUCCESSFUL_PROJECT = build_project(NAME_1,
                                  ::Project::Constants::Activity::SLEEPING,
                                  ::Project::Constants::LastBuildStatus::SUCCESS)

    SUCCESSFUL_PROJECT_BUILDING = build_project(NAME_1,
                                          ::Project::Constants::Activity::BUILDING,
                                          ::Project::Constants::LastBuildStatus::SUCCESS)

    FAILED_PROJECT = build_project(NAME_1,
                              ::Project::Constants::Activity::SLEEPING,
                              ::Project::Constants::LastBuildStatus::FAILURE)

    FAILED_PROJECT_BUILDING = build_project(NAME_1,
                                      ::Project::Constants::Activity::BUILDING,
                                      ::Project::Constants::LastBuildStatus::FAILURE)

  end

  module XML
    NO_PROJECTS = "<Projects></Projects>"
    ONE_PROJECT = %Q{
                    <Projects>
                       <Project
                       name="#{Project::NAME_1}"
                       activity="#{Project::ACTIVITY}"
                       lastBuildStatus="#{Project::LAST_BUILD_STATUS}"
                       lastBuildLabel="#{Project::LAST_BUILD_LABEL}"
                       lastBuildTime="#{Project::LAST_BUILD_TIME}"
                       nextBuildTime="#{Project::NEXT_BUILD_TIME}"
                       webUrl="#{Project::WEB_URL}"/>
                     </Projects>
                    }

    MULTIPLE_PROJECTS = %Q{
                     <Projects>
                        <Project
                        name="#{Project::NAME_1}"
                        activity="#{Project::ACTIVITY}"
                        lastBuildStatus="#{Project::LAST_BUILD_STATUS}"
                        lastBuildLabel="#{Project::LAST_BUILD_LABEL}"
                        lastBuildTime="#{Project::LAST_BUILD_TIME}"
                        nextBuildTime="#{Project::NEXT_BUILD_TIME}"
                        webUrl="#{Project::WEB_URL}"/>
                        <Project
                        name="#{Project::NAME_2}"
                        activity="#{Project::ACTIVITY}"
                        lastBuildStatus="#{Project::LAST_BUILD_STATUS}"
                        lastBuildLabel="#{Project::LAST_BUILD_LABEL}"
                        lastBuildTime="#{Project::LAST_BUILD_TIME}"
                        nextBuildTime="#{Project::NEXT_BUILD_TIME}"
                        webUrl="#{Project::WEB_URL}"/>
                      </Projects>
                     }

    def build_xml(activities)

      xml_document = "<Projects>"

      activities.each do |a|
        activity = a[:activity]
        last_build_status = a[:last_build_status]

        xml_document += %Q{
                      <Projects>
                       <Project
                       name="#{Project::NAME_1}"
                       activity="#{activity}"
                       lastBuildStatus="#{last_build_status}"
                       lastBuildLabel="#{Project::LAST_BUILD_LABEL}"
                       lastBuildTime="#{Project::LAST_BUILD_TIME}"
                       nextBuildTime="#{Project::NEXT_BUILD_TIME}"
                       webUrl=\"#{Project::WEB_URL}"/>
                     </Projects>
                    }
      end

      xml_document +="</Projects>"

      return xml_document
    end

    module_function :build_xml
  end

  module YAML

    VALID_URL    = "http:://localhost:4567"
    INVALID_URL  = "invalid_url"

    VALID_SLEEP    = 10
    INVALID_SLEEP  = "Not a number"

    USE_AUTH = true

    VALID_USERNAME = "username"
    VALID_PASSWORD = "password"

    INVALID_YAML = {}.to_yaml

    VALID_YAML = { "url" => VALID_URL,
                   "sleep" => VALID_SLEEP,
                   "auth" => { "enabled" => USE_AUTH,
                               "username" => VALID_USERNAME,
                               "password" => VALID_PASSWORD
                            }
                 }.to_yaml

    INVALID_URL_YAML = { "url" => INVALID_URL,
                         "sleep" => VALID_SLEEP,
                         "auth" => { "enabled" => USE_AUTH,
                                     "username" => VALID_USERNAME,
                                     "password" => VALID_PASSWORD
                                   }
                       }.to_yaml

    INVALID_SLEEP_YAML = { "url" => VALID_URL,
                           "sleep" => INVALID_SLEEP,
                           "auth" => { "enabled" => USE_AUTH,
                                       "username" => VALID_USERNAME,
                                       "password" => VALID_PASSWORD
                                     }
                         }.to_yaml
  end

end