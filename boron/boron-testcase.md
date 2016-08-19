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
root@node-2:~# ovs-ofctl -O Openflow13 dump-flows br-int table=11
OFPST_FLOW reply (OF1.3) (xid=0x2):
 cookie=0x0, duration=383.938s, table=11, n_packets=66, n_bytes=4884, tcp,reg0=0x1,tp_dst=80 actions=move:NXM_NX_TUN_ID[0..31]->NXM_NX_NSH_C2[],push_nsh,load:0x1->NXM_NX_NSH_MDTYPE[],load:0x3->NXM_NX_NSH_NP[],load:0->NXM_NX_NSH_C1[],load:0->NXM_NX_NSP[0..23],load:0xff->NXM_NX_NSI[],load:0->NXM_NX_TUN_IPV4_DST[],load:0->NXM_NX_TUN_ID[0..31],resubmit(,0)
 cookie=0x0, duration=383.936s, table=11, n_packets=66, n_bytes=4884, tcp,reg0=0x1,tp_dst=22 actions=move:NXM_NX_TUN_ID[0..31]->NXM_NX_NSH_C2[],push_nsh,load:0x1->NXM_NX_NSH_MDTYPE[],load:0x3->NXM_NX_NSH_NP[],load:0->NXM_NX_NSH_C1[],load:0->NXM_NX_NSP[0..23],load:0xff->NXM_NX_NSI[],load:0->NXM_NX_TUN_IPV4_DST[],load:0->NXM_NX_TUN_ID[0..31],resubmit(,0)
 cookie=0x0, duration=1766.910s, table=11, n_packets=4563, n_bytes=408052, priority=0 actions=goto_table:21
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

1. The `server_presetup_CI.bash` throws the following but it completes and the testcase can be run 
   [FIXED (modify poc.tacker-up.sh + add ssh keys manually]:
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
