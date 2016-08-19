# Boron Testcase

## [19/8/2016] Tacker setup failure

Tacker service does not start. Tacker log gives
```
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/bin/tacker-server", line 10, in <module>
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/cmd/server.py", line 48, in main
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/service.py", line 98, in serve_wsgi
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/openstack/common/excutils.py", line 82, in __exit__
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/service.py", line 95, in serve_wsgi
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/service.py", line 66, in start
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/service.py", line 105, in _run_wsgi
2016-08-19 07:41:21.694 30468 TRACE tacker   File "/usr/lib/python2.7/dist-packages/tacker/common/config.py", line 137, in load_paste_app
2016-08-19 07:41:21.694 30468 TRACE tacker ConfigFilesNotFoundError: Failed to find some config files: api-paste.ini
2016-08-19 07:41:21.694 30468 TRACE tacker 
```


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

1. The `server_presetup_CI.bash` throws the following but it completes and the testcase can be run:
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
2. The `sfc.py` testcase seems to have some trouble creating the SFs as shown in the log below
   ```
checking if SFs are up:  | 3724f84b-09f4-4890-a962-458f59ce9dba | testVNF1 | firewall1-example |          | PENDING_CREATE |    

| 9b24b5ae-ac52-4900-856e-6f6657ebbe11 | testVNF2 | firewall2-example |          | PENDING_CREATE |    

checking if SFs are up:  | 9b24b5ae-ac52-4900-856e-6f6657ebbe11 | testVNF2 | firewall2-example |          | PENDING_CREATE |   
checking if SFs are up:  
Request Failed: internal server error while processing your request.
Request Failed: internal server error while processing your request.
   ```
3. I try to get the flows using the `dump_flows.sh` script.
   The flows seem to be created only in the compute node as show in the following printscreen
![dump_flows output](https://raw.githubusercontent.com/georgepar/sfc-work/master/boron/flows.png)
4. The `sfc.py` testcase errors out (see the above printscreen), so I tried to create a fix. (Still testing)
