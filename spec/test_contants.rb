require 'yaml'

require_relative "../src/model/project"

module TestConstants

  module Project
    Name = "HelloWorld"
    Name2 = "GoodbyeWorld"

    Activity = ::Project::Constants::Activity::SLEEPING
    LastBuildStatus = ::Project::Constants::LastBuildStatus::SUCCESS
    LastBuildLabel = "13"
    LastBuildTime = "2005-09-15T17:33:07.6447696+01:00"
    NextBuildTime = "2005-10-04T14:31:51.7799600+01:00"
    WebURL = "http://example/"

    def buildTest(name = Name, activity = Activity, lastBuildStatus = LastBuildStatus)
      ::Project::Builder.new(name, activity)
      .lastBuildStatus(lastBuildStatus)
      .lastBuildLabel(LastBuildLabel)
      .lastBuildTime(LastBuildTime)
      .nextBuildTime(NextBuildTime)
      .webUrl(WebURL).build()
    end

    module_function :buildTest

    SampleProject1 = buildTest(Name)
    SampleProject2 = buildTest(Name2)

    SuccessfulProject = buildTest(Name,
                                  ::Project::Constants::Activity::SLEEPING,
                                  ::Project::Constants::LastBuildStatus::SUCCESS)

    SuccessfulProjectBuilding = buildTest(Name,
                                          ::Project::Constants::Activity::BUILDING,
                                          ::Project::Constants::LastBuildStatus::SUCCESS)

    FailedProject = buildTest(Name,
                              ::Project::Constants::Activity::SLEEPING,
                              ::Project::Constants::LastBuildStatus::FAILURE)

    FailedProjectBuilding = buildTest(Name,
                                      ::Project::Constants::Activity::BUILDING,
                                      ::Project::Constants::LastBuildStatus::FAILURE)

  end

  module XML
    NoProjects = "<Projects></Projects>"
    OneProject = %Q{
                    <Projects>
                       <Project
                       name=\"#{Project::Name}\"
                       activity=\"#{Project::Activity}\"
                       lastBuildStatus=\"#{Project::LastBuildStatus}\"
                       lastBuildLabel=\"#{Project::LastBuildLabel}\"
                       lastBuildTime=\"#{Project::LastBuildTime}\"
                       nextBuildTime=\"#{Project::NextBuildTime}\"
                       webUrl=\"#{Project::WebURL}\"/>
                     </Projects>
                    }
    MultipleProjects = %Q{
                     <Projects>
                        <Project
                        name=\"#{Project::Name}\"
                        activity=\"#{Project::Activity}\"
                        lastBuildStatus=\"#{Project::LastBuildStatus}\"
                        lastBuildLabel=\"#{Project::LastBuildLabel}\"
                        lastBuildTime=\"#{Project::LastBuildTime}\"
                        nextBuildTime=\"#{Project::NextBuildTime}\"
                        webUrl=\"#{Project::WebURL}\"/>
                        <Project
                        name=\"#{Project::Name2}\"
                        activity=\"#{Project::Activity}\"
                        lastBuildStatus=\"#{Project::LastBuildStatus}\"
                        lastBuildLabel=\"#{Project::LastBuildLabel}\"
                        lastBuildTime=\"#{Project::LastBuildTime}\"
                        nextBuildTime=\"#{Project::NextBuildTime}\"
                        webUrl=\"#{Project::WebURL}\"/>
                      </Projects>
                     }
  end

  module YAML

    ValidUrl    = "http:://localhost:4567"
    InvalidUrl  = "invalid_url"

    ValidSleep    = 10
    InvalidSleep  = "Not a number"

    ValidUsername = "user"
    ValidPassword = "pass"

    AuthHash = {"user" => ValidUsername, "pass" => ValidPassword}

    ValidYAMLNoAuth         = {"url"=>ValidUrl, "sleep"=>ValidSleep}

    InvalidUrlYAML    = {"url"=>InvalidUrl, "sleep"=>ValidSleep}
    NoUrlYAML         = {"sleep"=>ValidSleep}

    InvalidSleepYAML  = {"url"=>ValidUrl, "sleep"=>InvalidSleep}
    NoSleepYAML       = {"url"=>ValidUrl}

    ValidYAMLWithAuth = {"url"=>ValidUrl, "sleep"=>ValidSleep, "auth" => AuthHash}

    NoUsernameYAML = {"url"=>ValidUrl, "sleep"=>ValidSleep, "auth" => {"pass" => ValidPassword}}
    NoPasswordYAML = {"url"=>ValidUrl, "sleep"=>ValidSleep, "auth" => {"user" => ValidUsername}}

  end

end