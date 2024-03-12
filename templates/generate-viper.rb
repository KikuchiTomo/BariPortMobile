V = "View.swift"
I = "Interactor.swift"
P = "Presenter.swift"
E = "Entity.swift"
R = "Router.swift"

IN_PATH = "templates/"
PROJECT_ROOT = "BariPort/Features/"

print("Feature Name: ")
FeatureName = gets.chomp

print("Screen Name: ")
ScreenName = gets.chomp

`mkdir -p #{PROJECT_ROOT + FeatureName}`
`mkdir -p #{PROJECT_ROOT + FeatureName}/Screens`
`mkdir -p #{PROJECT_ROOT + FeatureName}/Screens/#{ScreenName}`

puts ""

def writeTemplate(template_name)
  output_path = PROJECT_ROOT + FeatureName + "/Screens/" + ScreenName + "/" + ScreenName + template_name
  template_path = IN_PATH + template_name

  search =`ls #{output_path} 2> /dev/null`
  if search != ""
    puts " ******* Skip " + output_path + " *******"
    return 
  end
  puts "Generate " + output_path

  
  fd = File.open(output_path, "w")
  File.open(template_path, "r").each{ |line|
    out_line = line.gsub(/{{screen}}/, ScreenName)
    fd.puts(out_line)
  }

  fd.close()
end

writeTemplate(V)
writeTemplate(I)
writeTemplate(P)
writeTemplate(E)
writeTemplate(R)
