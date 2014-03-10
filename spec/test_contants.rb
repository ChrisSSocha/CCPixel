require_relative "../src/project"

module Constants

  module Project
    Name = "HelloWorld"
    Activity = "Sleeping"
    LastBuildStatus = "Success"
    LastBuildLabel = "13"
    LastBuildTime = "2005-09-15T17:33:07.6447696+01:00"
    NextBuildTime = "2005-10-04T14:31:51.7799600+01:00"
    WebURL = "http://example/"

    Name2 = "GoodbyeWorld"

    SampleProject1 = ::Project::Builder.new(Name, Activity)
    .lastBuildStatus(LastBuildStatus)
    .lastBuildLabel(LastBuildLabel)
    .lastBuildTime(LastBuildTime)
    .nextBuildTime(NextBuildTime)
    .webUrl(WebURL).build()

    SampleProject2 = ::Project::Builder.new(Name2, Activity)
    .lastBuildStatus(LastBuildStatus)
    .lastBuildLabel(LastBuildLabel)
    .lastBuildTime(LastBuildTime)
    .nextBuildTime(NextBuildTime)
    .webUrl(WebURL).build()
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

end