
# htdocs/sfv.txt.rb: export crc32 in sfv formatA
# parameters:
#   pack:  "/sfv.txt.rb?pack=21"
#   range: "/sfv.txt.rb?pack=21;last=29"
#   group: "/sfv.txt.rb?group=ZZZ"

now = Time.now.to_s

bot = IrofferEvent.new
version = bot.irconfig( "version" )

puts "; Generated by #{version} on #{now}\r"
puts ";\r"

require "cgi"

cgi = CGI.new('html4Tr')  # New CGI object

def get_post( cgi, name, fallback = '' )
  val = cgi.params[ name ][0]
  if val.nil?
    return fallback
  end
  return val
end

def print_head( bot, pack, group = nil )
  bytes = bot.info_pack(pack, "bytes" )
  if bytes.nil?
    return nil
  end
  if not group.nil?
    if bot.info_pack(pack, "group" ) != group
      return pack + 1
    end
  end
  mtime = bot.info_pack(pack, "mtime" )
  file = bot.info_pack(pack, "file" )
  file.sub!( /^.*\//, '' )
  printf( ";%13u  %s %s\r\n", bytes, mtime, file )
  return pack + 1
end

def print_data( bot, pack, group = nil )
  file = bot.info_pack(pack, "file" )
  if file.nil?
    return nil
  end
  if not group.nil?
    if bot.info_pack(pack, "group" ) != group
      return pack + 1
    end
  end
  file.sub!( /^.*\//, '' )
  crc32 = bot.info_pack(pack, "crc32" )
  printf( "%s %s\r\n", file, crc32 )
  return pack + 1
end

first = get_post( cgi, 'pack', 1 ).to_i
last = get_post( cgi, 'last', first.to_s ).to_i
group = get_post( cgi, 'group', nil )

if not group.nil?
  pack = 1
  while true do
    pack = print_head( bot, pack, group )
    if pack.nil?
      break
    end
  end

  pack = 1
  while true do
    pack = print_data( bot, pack, group )
    if pack.nil?
      break
    end
  end
else
  pack = first
  while pack <= last do
    pack = print_head( bot, pack )
    if pack.nil?
      break
    end
  end

  pack = first
  while pack <= last do
    pack = print_data( bot, pack )
    if pack.nil?
      break
    end
  end
end

# eof