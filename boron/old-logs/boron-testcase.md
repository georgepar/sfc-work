# Boron Testcase

## [19/8/2016] Testcase with OpenDaylight Boron RC0

Test Output:
```
2016-08-19 13:13:58,536 - ODL_SFC - INFO - TEST 1 [PASSED] ==> SSH BLOCKED
2016-08-19 13:14:03,837 - ODL_SFC - ERROR - TEST 2 [FAILED] ==> HTTP BLOCKED
```

Karaf Log:
```
2016-08-19 13:12:11,106 | ERROR | ntLoopGroup-11-2 | DeviceFlowRegistryImpl           | 298 - org.opendaylight.openflowplugin.impl - 0.3.0.Boron-RC0 | Flow with flowId Ingress_DHCPv6_Server47_fa:16:3e:71:c8:2f_Permit_ already exists in table 91

2016-08-19 13:12:11,107 | ERROR | ntLoopGroup-11-2 | DeviceFlowRegistryImpl           | 298 - org.opendaylight.openflowplugin.impl - 0.3.0.Boron-RC0 | Flow with flowId Egress_DHCP_Client_Permit_ already exists in table 41

...

2016-08-19 13:12:11,298 | INFO  | ntDispatcherImpl | OF13Provider                     | 325 - org.opendaylight.netvirt.openstack.net-virt-providers - 1.3.0.Boron-RC0 | Added TunnelPort : portName: vxlan-192.168.2.2

2016-08-19 13:12:11,298 | INFO  | ntDispatcherImpl | OF13Provider                     | 325 - org.opendaylight.netvirt.openstack.net-virt-providers - 1.3.0.Boron-RC0 | Tunnel vxlan-192.168.2.2 is present in br-int of ovsdb://uuid/cc75c3a0-6d5b-4fa4-90cd-c538578c8c95/bridge/br-int

...
```

Flows: 
```
root@node-2:~# ovs-ofctl -O Openflow13 dump-flows br-int | cut -d',' -f3-
OFPST_FLOW reply (OF1.3) (xid=0x2):
 table=0, n_packets=327, n_bytes=36297, dl_type=0x88cc actions=CONTROLLER:65535
 table=0, n_packets=9832, n_bytes=840346, priority=6 actions=goto_table:1
 table=1, n_packets=1238, n_bytes=106766, in_port=2,dl_src=fa:16:3e:4c:d3:69 actions=set_field:0x2f->tun_id,load:0x1->NXM_NX_REG0[],goto_table:11
 table=1, n_packets=1119, n_bytes=95146, in_port=3,dl_src=fa:16:3e:36:ba:03 actions=set_field:0x2f->tun_id,load:0x1->NXM_NX_REG0[],goto_table:11
 table=1, n_packets=1317, n_bytes=113981, in_port=4,dl_src=fa:16:3e:cd:d4:01 actions=set_field:0x2f->tun_id,load:0x1->NXM_NX_REG0[],goto_table:11
 table=1, n_packets=1340, n_bytes=116061, in_port=5,dl_src=fa:16:3e:1d:de:0e actions=set_field:0x2f->tun_id,load:0x1->NXM_NX_REG0[],goto_table:11
 table=1, n_packets=453, n_bytes=37430, in_port=6,dl_src=fa:16:3e:88:7e:85 actions=set_field:0x2f->tun_id,load:0x1->NXM_NX_REG0[],goto_table:11
 table=1, n_packets=4357, n_bytes=370314, tun_id=0x2f,in_port=1 actions=load:0x2->NXM_NX_REG0[],goto_table:11
 table=1, n_packets=0, n_bytes=0, priority=8192,in_port=2 actions=drop
 table=1, n_packets=0, n_bytes=0, priority=8192,in_port=3 actions=drop
 table=1, n_packets=0, n_bytes=0, priority=8192,in_port=4 actions=drop
 table=1, n_packets=0, n_bytes=0, priority=8192,in_port=5 actions=drop
 table=1, n_packets=0, n_bytes=0, priority=8192,in_port=6 actions=drop
 table=1, n_packets=8, n_bytes=648, priority=0 actions=goto_table:11
 table=11, n_packets=66, n_bytes=4884, tcp,reg0=0x1,tp_dst=80 actions=move:NXM_NX_TUN_ID[0..31]->NXM_NX_NSH_C2[],push_nsh,load:0x1->NXM_NX_NSH_MDTYPE[],load:0x3->NXM_NX_NSH_NP[],load:0->NXM_NX_NSH_C1[],load:0->NXM_NX_NSP[0..23],load:0xff->NXM_NX_NSI[],load:0->NXM_NX_TUN_IPV4_DST[],load:0->NXM_NX_TUN_ID[0..31],resubmit(,0)
 table=11, n_packets=66, n_bytes=4884, tcp,reg0=0x1,tp_dst=22 actions=move:NXM_NX_TUN_ID[0..31]->NXM_NX_NSH_C2[],push_nsh,load:0x1->NXM_NX_NSH_MDTYPE[],load:0x3->NXM_NX_NSH_NP[],load:0->NXM_NX_NSH_C1[],load:0->NXM_NX_NSP[0..23],load:0xff->NXM_NX_NSI[],load:0->NXM_NX_TUN_IPV4_DST[],load:0->NXM_NX_TUN_ID[0..31],resubmit(,0)
 table=11, n_packets=9700, n_bytes=830578, priority=0 actions=goto_table:21
 table=21, n_packets=0, n_bytes=0, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.5,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:cd:d4:01->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163ecdd401->NXM_NX_ARP_SHA[],load:0xb000005->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=110, n_bytes=4620, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.2,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:71:c8:2f->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e71c82f->NXM_NX_ARP_SHA[],load:0xb000002->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=0, n_bytes=0, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.7,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:88:7e:85->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e887e85->NXM_NX_ARP_SHA[],load:0xb000007->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=0, n_bytes=0, priority=1024,arp,tun_id=0x2,arp_tpa=192.168.111.1,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:42:f5:9e->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e42f59e->NXM_NX_ARP_SHA[],load:0xc0a86f01->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=1, n_bytes=42, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.4,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:36:ba:03->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e36ba03->NXM_NX_ARP_SHA[],load:0xb000004->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=5, n_bytes=210, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.1,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:04:e6:c4->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e04e6c4->NXM_NX_ARP_SHA[],load:0xb000001->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=0, n_bytes=0, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.3,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:4c:d3:69->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e4cd369->NXM_NX_ARP_SHA[],load:0xb000003->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=0, n_bytes=0, priority=1024,arp,tun_id=0x2f,arp_tpa=11.0.0.6,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],set_field:fa:16:3e:1d:de:0e->eth_src,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xfa163e1dde0e->NXM_NX_ARP_SHA[],load:0xb000006->NXM_OF_ARP_SPA[],IN_PORT
 table=21, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:31
 table=31, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:41
 table=41, n_packets=0, n_bytes=0, priority=61011,udp,in_port=2,tp_src=67,tp_dst=68 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp6,in_port=2,tp_src=547,tp_dst=546 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp,in_port=3,tp_src=67,tp_dst=68 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp6,in_port=3,tp_src=547,tp_dst=546 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp,in_port=4,tp_src=67,tp_dst=68 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp6,in_port=4,tp_src=547,tp_dst=546 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp,in_port=5,tp_src=67,tp_dst=68 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp6,in_port=5,tp_src=547,tp_dst=546 actions=drop
 table=41, n_packets=3, n_bytes=1026, priority=61012,udp,in_port=6,tp_src=68,tp_dst=67 actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61012,udp6,in_port=6,tp_src=546,tp_dst=547 actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61011,udp,in_port=6,tp_src=67,tp_dst=68 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61011,udp6,in_port=6,tp_src=547,tp_dst=546 actions=drop
 table=41, n_packets=0, n_bytes=0, priority=61010,arp,arp_sha=fa:16:3e:4c:d3:69 actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61010,arp,arp_sha=fa:16:3e:36:ba:03 actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61010,arp,arp_sha=fa:16:3e:cd:d4:01 actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61010,arp,arp_sha=fa:16:3e:1d:de:0e actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61010,arp,arp_sha=fa:16:3e:88:7e:85 actions=goto_table:51
 table=41, n_packets=8, n_bytes=648, priority=61007,ipv6,dl_src=fa:16:3e:4c:d3:69 actions=goto_table:51
 table=41, n_packets=1083, n_bytes=92722, priority=61007,ip,dl_src=fa:16:3e:36:ba:03 actions=goto_table:51
 table=41, n_packets=8, n_bytes=648, priority=61007,ipv6,dl_src=fa:16:3e:cd:d4:01 actions=goto_table:51
 table=41, n_packets=1301, n_bytes=113211, priority=61007,ip,dl_src=fa:16:3e:1d:de:0e actions=goto_table:51
 table=41, n_packets=8, n_bytes=648, priority=61007,ipv6,dl_src=fa:16:3e:88:7e:85 actions=goto_table:51
 table=41, n_packets=5, n_bytes=370, priority=61007,tcp,tp_dst=22,tcp_flags=syn actions=goto_table:51
 table=41, n_packets=0, n_bytes=0, priority=61003,tcp,tcp_flags=syn actions=drop
 table=41, n_packets=7163, n_bytes=614723, priority=0 actions=goto_table:51
 table=51, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:61
 table=61, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:71
 table=71, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:81
 table=81, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:91
 table=91, n_packets=0, n_bytes=0, priority=61010,arp,arp_tha=fa:16:3e:4c:d3:69 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61010,arp,arp_tha=fa:16:3e:36:ba:03 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61010,arp,arp_tha=fa:16:3e:cd:d4:01 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61010,arp,arp_tha=fa:16:3e:1d:de:0e actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61010,arp,arp_tha=fa:16:3e:88:7e:85 actions=goto_table:101
 table=91, n_packets=5, n_bytes=370, priority=61007,tcp,tp_dst=22,tcp_flags=syn actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61007,icmp,dl_dst=fa:16:3e:4c:d3:69 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61007,icmp,dl_dst=fa:16:3e:36:ba:03 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61007,icmp,dl_dst=fa:16:3e:88:7e:85 actions=goto_table:101
 table=91, n_packets=364, n_bytes=30648, priority=61007,ip,dl_dst=fa:16:3e:88:7e:85 actions=goto_table:101
 table=91, n_packets=1086, n_bytes=92141, priority=61007,ip,dl_dst=fa:16:3e:cd:d4:01 actions=goto_table:101
 table=91, n_packets=873, n_bytes=73749, priority=61007,ip,dl_dst=fa:16:3e:36:ba:03 actions=goto_table:101
 table=91, n_packets=889, n_bytes=76142, priority=61007,ip,dl_dst=fa:16:3e:4c:d3:69 actions=goto_table:101
 table=91, n_packets=438, n_bytes=36304, priority=61007,ip,dl_dst=fa:16:3e:1d:de:0e actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61006,udp,dl_src=fa:16:3e:71:c8:2f,dl_dst=fa:16:3e:88:7e:85,tp_src=67,tp_dst=68 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61006,udp6,dl_src=fa:16:3e:71:c8:2f,dl_dst=fa:16:3e:88:7e:85,tp_src=547,tp_dst=546 actions=goto_table:101
 table=91, n_packets=0, n_bytes=0, priority=61004,tcp,tcp_flags=syn actions=goto_table:101
 table=91, n_packets=5924, n_bytes=514457, priority=0 actions=goto_table:101
 table=101, n_packets=9584, n_bytes=825706, priority=0 actions=goto_table:111
 table=111, n_packets=0, n_bytes=0, tun_id=0x2,dl_dst=fa:16:3e:5f:81:26 actions=output:1
 table=111, n_packets=0, n_bytes=0, tun_id=0x2,dl_dst=fa:16:3e:42:f5:9e actions=output:1
 table=111, n_packets=4996, n_bytes=411631, tun_id=0x2f,dl_dst=fa:16:3e:71:c8:2f actions=output:1
 table=111, n_packets=173, n_bytes=36453, tun_id=0x2f,dl_dst=fa:16:3e:04:e6:c4 actions=output:1
 table=111, n_packets=891, n_bytes=76290, tun_id=0x2f,dl_dst=fa:16:3e:4c:d3:69 actions=output:2
 table=111, n_packets=894, n_bytes=76182, tun_id=0x2f,dl_dst=fa:16:3e:36:ba:03 actions=output:3
 table=111, n_packets=1087, n_bytes=92215, tun_id=0x2f,dl_dst=fa:16:3e:cd:d4:01 actions=output:4
 table=111, n_packets=1121, n_bytes=94979, tun_id=0x2f,dl_dst=fa:16:3e:1d:de:0e actions=output:5
 table=111, n_packets=364, n_bytes=30648, tun_id=0x2f,dl_dst=fa:16:3e:88:7e:85 actions=output:6
 table=111, n_packets=0, n_bytes=0, priority=16384,reg0=0x2,tun_id=0x2f,dl_dst=01:00:00:00:00:00/01:00:00:00:00:00 actions=output:2,output:3,output:4,output:5,output:6
 table=111, n_packets=50, n_bytes=6660, priority=16383,reg0=0x1,tun_id=0x2f,dl_dst=01:00:00:00:00:00/01:00:00:00:00:00 actions=output:2,output:1,output:3,output:4,output:5,output:6
 table=111, n_packets=0, n_bytes=0, priority=8192,tun_id=0x2f actions=drop
 table=111, n_packets=8, n_bytes=648, priority=0 actions=drop
```

## [19/8/2016] Tacker setup failure [FIXED]

## [18/9/2016] OpenDaylight error

The testcase fails with 

```
2016-08-18 12:41:40,512 - ODL_SFC - ERROR - TEST 1 [FAILED] ==> SSH NOT BLOCKED
```

In `karaf.log` we get this WARN message

```
2016-08-18 12:17:31,539 | WARN  | entLoopGroup-9-2 | ListDeserializer                 | 170 - org.opendaylight.openflowjava.openflow-protocol-impl - 0.8.0.Boron | Problem during reading table feature property. Skipping unknown feature property: msgVersion: 4 objectClass: org.opendaylight.yang.gen.v1.urn.opendaylight.openflow.oxm.rev150225.match.entries.grouping.MatchEntry msgType: 1 oxm_field: 35 experimenterID: null.If more information is needed, set org.opendaylight.openflowjava do DEBUG log level.

```

And this exception

```
java.lang.IllegalStateException: Deserializer for key: msgVersion: 4 objectClass: org.opendaylight.yang.gen.v1.urn.opendaylight.openflow.common.action.rev150203.actions.grouping.Action msgType: 7 experimenterID: null was not found - please verify that all needed deserializers ale loaded correctly
	at org.opendaylight.openflowjava.protocol.impl.deserialization.DeserializerRegistryImpl.getDeserializer(DeserializerRegistryImpl.java:69)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.util.ListDeserializer.deserializeList(ListDeserializer.java:52)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.instruction.AbstractActionInstructionDeserializer.deserializeActions(AbstractActionInstructionDeserializer.java:38)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.instruction.ApplyActionsInstructionDeserializer.deserialize(ApplyActionsInstructionDeserializer.java:36)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.instruction.ApplyActionsInstructionDeserializer.deserialize(ApplyActionsInstructionDeserializer.java:25)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.util.ListDeserializer.deserializeList(ListDeserializer.java:53)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.factories.MultipartReplyMessageFactory.setFlow(MultipartReplyMessageFactory.java:304)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.factories.MultipartReplyMessageFactory.deserialize(MultipartReplyMessageFactory.java:198)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.factories.MultipartReplyMessageFactory.deserialize(MultipartReplyMessageFactory.java:148)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.deserialization.DeserializationFactory.deserialize(DeserializationFactory.java:59)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.core.OFDecoder.decode(OFDecoder.java:55)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at org.opendaylight.openflowjava.protocol.impl.core.OFDecoder.decode(OFDecoder.java:28)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at io.netty.handler.codec.MessageToMessageDecoder.channelRead(MessageToMessageDecoder.java:88)[114:io.netty.codec:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:342)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:328)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:321)[113:io.netty.transport:4.0.37.Final]
	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:293)[114:io.netty.codec:4.0.37.Final]
	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:267)[114:io.netty.codec:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:342)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:328)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:321)[113:io.netty.transport:4.0.37.Final]
	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:293)[114:io.netty.codec:4.0.37.Final]
	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:267)[114:io.netty.codec:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:342)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:328)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:321)[113:io.netty.transport:4.0.37.Final]
	at io.netty.handler.timeout.ReadTimeoutHandler.channelRead(ReadTimeoutHandler.java:152)[116:io.netty.handler:4.0.37.Final]
	at org.opendaylight.openflowjava.protocol.impl.core.IdleHandler.channelRead(IdleHandler.java:39)[170:org.opendaylight.openflowjava.openflow-protocol-impl:0.8.0.Boron]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:342)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:328)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:321)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1280)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:342)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:328)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:890)[113:io.netty.transport:4.0.37.Final]
	at io.netty.channel.epoll.AbstractEpollStreamChannel$EpollStreamUnsafe.epollInReady(AbstractEpollStreamChannel.java:879)[117:io.netty.transport-native-epoll:4.0.37.Final]
	at io.netty.channel.epoll.EpollEventLoop.processReady(EpollEventLoop.java:387)[117:io.netty.transport-native-epoll:4.0.37.Final]
	at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:296)[117:io.netty.transport-native-epoll:4.0.37.Final]
	at io.netty.util.concurrent.SingleThreadEventExecutor$2.run(SingleThreadEventExecutor.java:112)[112:io.netty.common:4.0.37.Final]
	at io.netty.util.concurrent.DefaultThreadFactory$DefaultRunnableDecorator.run(DefaultThreadFactory.java:145)[112:io.netty.common:4.0.37.Final]
	at java.lang.Thread.run(Thread.java:745)[:1.8.0_14-internal]
```

A quick search leads to this (year old) [bug report](https://bugs.opendaylight.org/show_bug.cgi?id=2957)

This error seems to lead to collapsing of the `br-int` bridge
```
ovs-ofctl: br-int is not a bridge or a socket
```

## Various errors

1. The `server_presetup_CI.bash` throws the following but it completes and the testcase can be run [FIXED]:
   ```
W: GPG error: http://mirror.fuel-infra.org mos9.0-holdback Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY BCE5CC461FA22B08
W: GPG error: http://mirror.fuel-infra.org mos9.0-security Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY BCE5CC461FA22B08
W: GPG error: http://mirror.fuel-infra.org mos9.0-updates Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY BCE5CC461FA22B08   

...  

...  
Populating settings to 10.20.0.6 
Warning: Identity file /root/.ssh/id_rsa not accessible: No such file or directory.
ssh: connect to host 10.20.0.6 port 22: No route to host
Populating settings to 10.20.0.3
lost connection
Warning: Identity file /root/.ssh/id_rsa not accessible: No such file or directory.
Permission denied (publickey).
lost connection
...  
   ```
2. The `sfc.py` testcase errors out (see the above printscreen), so I tried to create a fix. [FIXED]
