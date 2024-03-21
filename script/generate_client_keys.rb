
body = <<"EOS"
internal struct BariPortAPIConfig{
    static let HostName: String = "#{ARGV[0]}"
}
EOS

print ARGV[0]

File.open("BariPortAPI/BariPortAPIConfig.swift", "w").puts(body)
