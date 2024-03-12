V = "view.swift"
I = "interactor.swift"
P = "presenter.swift"
E = "entity.swift"
R = "router.swift"

in_path = "templates/"
project = "BariPort/Features/"

print("Feature Name: ")
FeatureName = gets.chomp

print("Screen Name: ")
ScreenName = gets.chomp

`mkdir #{project + FeatureName}`


def writeTemplate(template_path, output_path, screen_name)
  fd = File.open(output_path, "w")
  File.open(template_path, "r").each{ |line|
    out_line = line.gsub(/{{screen}}/, sreen_name)
    fd.puts(out_line)
  }

  fd.close()
end
