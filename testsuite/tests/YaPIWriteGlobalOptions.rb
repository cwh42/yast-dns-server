# encoding: utf-8

# File:	YaPIWriteGlobalOptions.ycp
# Package:	Configuration of dns-server
# Summary:	Testsuite for writting global options for dns-server
# Authors:	Jiri Srain <jsrain@suse.cz>, Lukas Ocilka <locilka@suse.cz>
# Copyright:	Copyright 2004, Novell, Inc.  All rights reserved.
#
# $Id$
#
# Testsuite for writting global options for dns-server
require "yast"

module Yast
  class YaPIWriteGlobalOptionsClient < Client
    def main
      Yast.include self, "testsuite.rb"
      # testedfiles: DnsServer.pm DNSD.pm DnsZones.pm
      @I_READ = {
        "probe"     => {
          "architecture" => "i386",
          "has_apm"      => true,
          "has_pcmcia"   => false,
          "has_smp"      => false,
          "system"       => [],
          "memory"       => [],
          "cpu"          => [],
          "cdrom"        => { "manual" => [] },
          "floppy"       => { "manual" => [] },
          "is_uml"       => false
        },
        "product"   => {
          "features" => {
            "USE_DESKTOP_SCHEDULER" => "0",
            "IO_SCHEDULER"          => "cfg",
            "UI_MODE"               => "expert",
            "ENABLE_AUTOLOGIN"      => "0",
            "EVMS_CONFIG"           => "0"
          }
        },
        "sysconfig" => {
          "SuSEfirewall2"     => {
            "FW_ALLOW_FW_TRACEROUTE"   => "yes",
            "FW_AUTOPROTECT_SERVICES"  => "no",
            "FW_DEV_DMZ"               => "",
            "FW_DEV_EXT"               => "eth-id-00:c0:df:22:c6:a8",
            "FW_DEV_INT"               => "",
            "FW_IPSEC_TRUST"           => "no",
            "FW_LOG_ACCEPT_ALL"        => "no",
            "FW_LOG_ACCEPT_CRIT"       => "yes",
            "FW_LOG_DROP_ALL"          => "no",
            "FW_LOG_DROP_CRIT"         => "yes",
            "FW_MASQUERADE"            => "no",
            "FW_MASQ_NETS"             => "",
            "FW_PROTECT_FROM_INTERNAL" => "yes",
            "FW_ROUTE"                 => "no",
            "FW_SERVICES_DMZ_IP"       => "",
            "FW_SERVICES_DMZ_TCP"      => "",
            "FW_SERVICES_DMZ_UDP"      => "",
            "FW_SERVICES_EXT_IP"       => "",
            "FW_SERVICES_EXT_RPC"      => "nlockmgr status nfs nfs_acl mountd ypserv fypxfrd ypbind ypasswdd",
            "FW_SERVICES_EXT_TCP"      => "32768 5801 5901 dixie domain hostname microsoft-ds netbios-dgm netbios-ns netbios-ssn nfs ssh sunrpc",
            "FW_SERVICES_EXT_UDP"      => "222 bftp domain ipp sunrpc",
            "FW_SERVICES_INT_IP"       => "",
            "FW_SERVICES_INT_TCP"      => "ddd eee fff 44 55 66",
            "FW_SERVICES_INT_UDP"      => "aaa bbb ccc 11 22 33"
          },
          "personal-firewall" => { "REJECT_ALL_INCOMING_CONNECTIONS" => "" }
        }
      }
      @I_WRITE = {}
      @I_EXEC = {}

      TESTSUITE_INIT([@I_READ, @I_WRITE, @I_EXEC], nil)

      Yast.import "YaPI::DNSD"
      Yast.import "Mode"
      Yast.import "Progress"

      Mode.SetMode("test")

      @progress_orig = Progress.set(false)

      @READ = {
        "passwd"    => { "passwd" => { "pluslines" => [] } },
        "probe"     => {
          "architecture" => "i386",
          "has_apm"      => true,
          "has_pcmcia"   => false,
          "has_smp"      => false,
          "system"       => [],
          "memory"       => [],
          "cpu"          => [],
          "cdrom"        => { "manual" => [] },
          "floppy"       => { "manual" => [] },
          "is_uml"       => false
        },
        "product"   => {
          "features" => {
            "USE_DESKTOP_SCHEDULER" => "0",
            "IO_SCHEDULER"          => "cfg",
            "UI_MODE"               => "expert",
            "ENABLE_AUTOLOGIN"      => "0",
            "EVMS_CONFIG"           => "0"
          }
        },
        # Runlevel
        "init"      => {
          "scripts" => {
            "exists"   => true,
            "runlevel" => { "named" => { "start" => [], "stop" => [] } },
            # their contents is not important for ServiceAdjust
            "comment"  => {
              "named" => {}
            }
          }
        },
        "target"    => {
          "stat"  => {
            "atime"   => 1101890288,
            "ctime"   => 1101890286,
            "gid"     => 0,
            "inode"   => 29236,
            "isblock" => false,
            "ischr"   => false,
            "isdir"   => false,
            "isfifo"  => false,
            "islink"  => false,
            "isreg"   => true,
            "issock"  => false,
            "mtime"   => 1101890286,
            "nlink"   => 1,
            "size"    => 804,
            "uid"     => 0
          },
          "lstat" => {},
          "ycp"   => {}
        },
        "dns"       => {
          "named" => {
            "section" => { "options" => "", "zone \"localhost\" in" => "" },
            "value"   => {
              "options"               => {
                "directory" => ["\"/var/lib/named\""],
                "notify"    => ["no"]
              },
              "zone \"localhost\" in" => {
                "type" => ["master"],
                "file" => ["\"localhost.zone\""]
              },
              "acl"                   => []
            }
          },
          "zone"  => {
            "TTL"     => "1W",
            "records" => [
              { "key" => "", "type" => "NS", "value" => "@" },
              { "key" => "", "type" => "A", "value" => "127.0.0.1" },
              { "key" => "localhost2", "type" => "A", "value" => "127.0.0.2" }
            ],
            "soa"     => {
              "expiry"  => "6W",
              "mail"    => "root",
              "minimum" => "1W",
              "refresh" => "2D",
              "retry"   => "4H",
              "serial"  => 42,
              "server"  => "@",
              "zone"    => "@"
            }
          }
        },
        "sysconfig" => {
          "SuSEfirewall2"     => {
            "FW_ALLOW_FW_TRACEROUTE"   => "yes",
            "FW_AUTOPROTECT_SERVICES"  => "no",
            "FW_DEV_DMZ"               => "",
            "FW_DEV_EXT"               => "eth-id-00:c0:df:22:c6:a8",
            "FW_DEV_INT"               => "",
            "FW_IPSEC_TRUST"           => "no",
            "FW_LOG_ACCEPT_ALL"        => "no",
            "FW_LOG_ACCEPT_CRIT"       => "yes",
            "FW_LOG_DROP_ALL"          => "no",
            "FW_LOG_DROP_CRIT"         => "yes",
            "FW_MASQUERADE"            => "no",
            "FW_MASQ_NETS"             => "",
            "FW_PROTECT_FROM_INTERNAL" => "yes",
            "FW_ROUTE"                 => "no",
            "FW_SERVICES_DMZ_IP"       => "",
            "FW_SERVICES_DMZ_TCP"      => "",
            "FW_SERVICES_DMZ_UDP"      => "",
            "FW_SERVICES_EXT_IP"       => "",
            "FW_SERVICES_EXT_RPC"      => "nlockmgr status nfs nfs_acl mountd ypserv fypxfrd ypbind ypasswdd",
            "FW_SERVICES_EXT_TCP"      => "32768 5801 5901 dixie domain hostname microsoft-ds netbios-dgm netbios-ns netbios-ssn nfs ssh sunrpc",
            "FW_SERVICES_EXT_UDP"      => "222 bftp domain ipp sunrpc",
            "FW_SERVICES_INT_IP"       => "",
            "FW_SERVICES_INT_TCP"      => "ddd eee fff 44 55 66",
            "FW_SERVICES_INT_UDP"      => "aaa bbb ccc 11 22 33"
          },
          "personal-firewall" => { "REJECT_ALL_INCOMING_CONNECTIONS" => "" },
          "network"           => {
            "config" => {
              "MODIFY_NAMED_CONF_DYNAMICALLY"  => "yes",
              "MODIFY_RESOLV_CONF_DYNAMICALLY" => "yes",
              "NETCONFIG_DNS_POLICY"           => "auto",
              "NETCONFIG_DNS_STATIC_SERVERS"   => ""
            }
          },
          "console"           => { "CONSOLE_ENCODING" => "utf8" },
          "language"          => {
            "RC_LANG"        => "en_US.UTF-8",
            "ROOT_USES_LANG" => "ctype"
          }
        },
        "target"    => {
          "stat"  => {
            "atime"   => 1101890288,
            "ctime"   => 1101890286,
            "gid"     => 0,
            "inode"   => 29236,
            "isblock" => false,
            "ischr"   => false,
            "isdir"   => false,
            "isfifo"  => false,
            "islink"  => false,
            "isreg"   => true,
            "issock"  => false,
            "mtime"   => 1101890286,
            "nlink"   => 1,
            "size"    => 804,
            "uid"     => 0
          },
          "lstat" => {},
          "yast2" => { "lang2iso.ycp" => {} },
          "size"  => 1,
          "ycp"   => {}
        }
      }
      @WRITE = {}
      @EXEC = {
        "target" => {
          "bash_output" => { "exit" => 1, "stdout" => "", "stderr" => "" },
          "bash"        => 1
        },
        "passwd" => { "init" => true }
      }

      @options = [
        { "key" => "dump-file", "value" => "\"/var/log/named_dump.db\"" },
        { "key" => "statistics-file", "value" => "\"/var/log/named.stats\"" }
      ]

      DUMP("==========================================================")
      TEST(lambda { YaPI::DNSD.WriteGlobalOptions({}, @options) }, [
        @READ,
        @WRITE,
        @EXEC
      ], nil)
      DUMP("==========================================================")

      nil
    end
  end
end

Yast::YaPIWriteGlobalOptionsClient.new.main
