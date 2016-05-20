# htdocs/json.txt.rb: export file info as list.

now = Time.now.to_s

bot = IrofferEvent.new
version = bot.irconfig( "version" )

puts "// Generated by #{version} on #{now}\r"

def print_head( bot, pack )
  bytes = bot.info_pack(pack, "bytes" )
  if bytes.nil?
    return nil
  end
  desc = bot.info_pack(pack, "desc" )
  bytes = bot.info_pack(pack, "bytes" )
  mtime = bot.info_pack(pack, "mtime" )
  mega = bytes / 1024 / 1024
  printf( 'p.k[%d] = {b:"%s", n:%d, s=%d f:"%s"};%s', $count, bot.mynick, pack, mega + 1,  desc, "\n" )
  $count += 1
  return pack + 1
end

$count = 0
pack = 1
while true do
  pack = print_head( bot, pack )
  if pack.nil?
    break
  end
end

# eof
