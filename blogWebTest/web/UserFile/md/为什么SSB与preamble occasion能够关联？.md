**原文链接：https://blog.csdn.net/qq_33206497/article/details/89931762**
5G中有SSB和beam概念，这里面是什么关系？先从几个问题入手：
# 为什么SSB与preamble occasion能够关联？
**疑问**：SSB包含PSS/SSS/PBCH，它是一个下行的概念，而PRACH occasion是一个上行的概念，两者为什么能关联？
答：在NR中的随机接入过程使用了波束，其中SSB在时域周期内有多次发送机会，并且有相应的编号，其可分别对应不同的波束，而对于UE而言，只有当SSB的波束扫描信号覆盖到UE时，UE才有机会发送preamble。而当网络端收到UE的preamble时，就知道下行最佳波束，换句话说，就是知道哪个波速指向了UE，因此SSB需要与preamble有一个关联，而preamble都是在PRACH occasion才能进行发送，则SSB与PRACH occasion进行了关联。<br><br>那么PRACH occasion是什么意思？
prach occasion可简单理解为，可用于发送preamble的时频域资源；可采用TDM（time-domain multiplexing，即Table 6.3.3.2-2~4中的time-domain prach occasions per prach slot）和FDM（frequency domain multiplexing，通过参数msg1-FDM配置）。
&nbsp;
&nbsp;

# 5G/NR SSB与PRACH occasion如何关联？
&nbsp;举例：SSB-per-rach-occation = 1/4，每个PRACH occasion对应竞争preamble = 56，msg1-FDM = 4，SSB num = 8，SCS = 15KHz，PRACH Configuration Index = 109(TDD制下FR1)。&nbsp; （不清楚每个PRACH occasion对应竞争preamble = 56是怎么来的，以及后面是怎么用的？哪位大侠知道希望解答下！）
这个56就是配的，就是ssb-perRACH-OccasionAndCB-PreamblesPerSSB这个配置的。表示一个occasion可以配置多少个竞争preamble.
上面参数totalNumberOfRA-Preambles来配置竞争和非竞争的preamble数。应该是N的整数倍。
解释：<br><br>&nbsp;&nbsp;&nbsp;&nbsp; 1) PRACH Configuration Index = 109，查38.211表6.3.3.2-3得出：<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- 在所有的帧中都有PRACH occasion(nSFN mod 1 = 0);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- 无线帧下的所有子帧都有PRACH occasion；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- 在每个子帧下的PRACH occasion的起始位置是从第9个符号开始；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- 每个子帧下一个PRACH slot；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- 一个PRACH slot中只有一个时域PRACH occasion；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- 一个PRACH长度为4，则占4个符号。<br>2) SSB-per-rach-occation = 1/4，表示一个SSB映射4个频域PRACH occasion；<br><br>&nbsp;&nbsp;&nbsp;&nbsp; 3) msg1-FDM = 4表示一个时域PRACH occasion有4个频域PRACH occasion；<br><br>&nbsp;&nbsp;&nbsp;&nbsp; 4) 举例得到SSB的PRACH occasion之间的映射如图21.16所示。<br>&nbsp; 图例解释：<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 因为SSB是一个下行的概念，但是SSB的编号与PRACH occasion有一一映射关系，因为SSB-per-rach-occation = 1/4，所以一个SSB就映射4个频域PRACH occasion，其中每个SSB编号与PRACH occasion都有一一映射关系，但是PRACH occasion不一定与SSB编号全部映射。同时，无线帧下的每个子帧都有时域PRACH occasion，并且时域PRACH occasion在每个子帧下起始符号是9，长度占4个符号，而每个时域PRACH occasion下都有4个频域PRACH occasion，因此图21.16中的每个子帧的第9个符号至12个符号表示时域PRACH occasion的长度，而频域是4个PRACH occasion。由于每个SSB都映射4个PRACH occasion，因此SSB0映射在另一个无线帧的无线子帧0号的4个PRACH occasion，依此类推。但是只有8个SSB，却在10个子帧下都有时域PRACH occasion，由于SSB与PRACH occasion的映射周期最小是1，因此子帧8、9号上的PRACH occasion没有SSB与其进行映射，则8、9号上的PRACH occasion被UE视为无效，UE不能在8、9号子帧的PRACH occasion发送preamble。<br>--------------------- <br><br>原文链接：https://blog.csdn.net/qq_33206497/article/details/89932046
&nbsp; &nbsp;图21.16 SSB与PRACH occasion之间的映射

# 5G/NR PRACH和preamble如何与SSB进行映射？
&nbsp;高层通过参数ssb-perRACH-OccasionAndCB-PreamblesPerSSB配置N(L1参数：SSB-per-rach-occasion)个SSB关联一个PRACH occasion(频域)，和每个SSB在每个有效PRACH occasion上基于竞争的preamble数(L1参数：CB-preambles-per-SSB)。其中对于N的配置有如下两种：<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 如果N < 1，则一个SSB映射到1/N个连续有效的PRACH occasion(频域)(例如：N = 1/8，则一个SSB映射8个PRACH occasion)，且R个连续索引的preamble映射到SSB n，0 <= n <= N-1，每个有效PRACH occasion从preamble索引0开始(例：N = 1/8，则一个SSB映射8个PRACH occasion，那么一个SSB中有8个preamble索引为0的起始点，因为一个PRACH occasion对应一个preamble索引为0的起始点，其SSB与preamble的映射分组示意图如图21.2所示)；
上面描述中说的R就是CB-preambles-per-SSB这个参数。若是N<1,则每个SSB都有R个连续的preamble索引。都是从0开始。而每个SSB又有1/N个occasion，所以一个SSB中就有1/N个preamble index为0的起始点。<br>
对于链路恢复，UE通过高层参数BeamFailureRecoveryConfig中携带ssb-perRACH-Occation指示N个SSB关联一个PRACH occasion。如果N < 1，则一个SSB映射到1/N个连续有效的PRACH occasion。如果N >= 1，则N个连续的SSB关联一个PRACH occasion。<br>
图21.2 SSB-per-rach-occation <= 1时每个SSB与preamble的映射分组示意图
&nbsp;
图21.3 SSB-per-rach-occation = 2时每个SSB与preamble的映射分组示意图
&nbsp;&nbsp;从上文可知，SSB与PRACH occasion是有映射关系的，其SSB映射到PRACH occasion的顺序应遵循如下几点：<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp; 首先，在一个PRACH occasion中preamble索引的顺序是递增的；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp; 第二，频率复用PRACH occasion的频率资源索引顺序是递增的；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp; 第三，在PRACH时隙内的时域复用PRACH occasion的时域资源索引的顺序是递增的；<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp; 第四，PRACH时隙索引的顺序是递增的。<br>下面通过举例来阐述两者的映射关系。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 例：8个SSB(编号：0~7)，msg1-FDM = 4(表示频域PRACH occasion的个数，详情参考第21.3节)(注：下文举例的PRACH occasion索引编号可能并不是从0开始，而是从1开始)。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssb-perRACH-Occasion = 1/4，其SSB与PRACH occasion映射示意图如图21.4所示：<br>
图21.4  ssb-perRACH-Occasion  = 1/4时SSB域PRACH occasion映射示意图
&nbsp;图21.4中表示的是，ssb-perRACH-Occasion = 1/4，表示一个SSB映射4个PRACH occasion，同时msg1-FDM = 4，表示一个时域PRACH occasion上有4个频域PRACH occasion，因此在第一个时域PRACH occasion上的4个频域PRACH occasion对应一个SSB，第二个时域PRACH occasion上的4个频域PRACH occasion对应另一个SSB，依此类推。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) ssb-perRACH-Occasion = 1，其SSB与PRACH occasion映射示意图如图21.5所示：<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.5 ssb-perRACH-Occasion = 1时SSB域PRACH occasion映射示意图<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.5中表示的是，，ssb-perRACH-Occasion = 1，表示一个SSB映射1个PRACH occasion，同时msg1-FDM = 4，表示一个时域PRACH occasion上有4个频域PRACH occasion，因此第一个时域PRACH occasion上的4个频域PRACH occasion分别对应一个SSB，其为SSB 0~3，而SSB数为8，此时还没有映射完，则根据SSB与PRACH occasion映射要求，因此在第二个时域PRACH occasion上的4个频域PRACH occasion依次以递增的顺序映射SSB 4~7，依此类推。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) ssb-perRACH-Occasion = 1/2，其SSB与PRACH occasion映射示意图如图21.6所示：<br>
&nbsp;图21.6 ssb-perRACH-Occasion = 1/2时SSB域PRACH occasion映射示意图<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.6中表示的是，ssb-perRACH-Occasion＝1/2，表示一个SSB映射2个PRACH occasion，同时msg1-FDM = 4，表示一个时域 PRACH occasion上有4个频域 PRACH occasion，因此在第一个时域 PRACH occasion上的4个频域 PRACH occasion，其中 PRACH occasion 0~1映射SSB 0， PRACH occasion 2～3映射SSB1。此时还没有映射完，则根据SSB与 PRACH occasion映射要求，因此在第二个时城 PRACH occasion上的4个频域 PRACH occasion依次以递增的顺序进行映射SSB，其中 PRACH occasion 0~1映射SSB 2， PRACH occasion&nbsp; 2~3映射SSB 3。在第三个时城 PRACH occasion上的4个频域 PRACH occasion的映射关系: PRACH occasion 0~1映射SSB 4， PRACH occasion 2~3映射SSB5。在第四个时域 PRACH occasion上的4个频域 PRACH occasion的映射关系: PRACH occasion 0~1映射SSB6， PRACH occasion 2~3映射SSB 7，以此类推<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3）ssb-perrach-occasion ＝ 2，其SSB与 PRACH occasion映射示意图如图21.7所示：<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.7 ssb-perRACH-Occasion = 2时SSB域PRACH occasion映射示意图
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.7中表示的是，ssb-perRACH-Occasion ＝ 2，表示2个SSB映射1个PRACH occasion，因此在第一个时域PRACH occasion上的4个频域PRACH occasion的映射如下：SSB 0/1映射PRACH occasion 0、SSB 2/3映射在PRACH occasion 1、SSB 4/5映射在PRACH occasion 2、SSB 6/7映射在PRACH occasion 3，依此类推。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4）ssb-perrach-occasion ＝ 8，其SSB与 PRACH occasion映射示意图如图21.8所示：<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.8 ssb-perRACH-Occasion = 8时SSB域PRACH occasion映射示意图
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 图21.8中表示的是，ssb-perRACH-Occasion ＝ 2，表示8个SSB映射1个PRACH occasion，因此在第一个时域PRACH occasion上的4个频域PRACH occasion都映射SSB 0~7，依此类推。<br><br>
下面这几个映射图看明白了，但是描述中的R是什么意思？R就是CB-preambles-per-SSB这个参数。
例如：N = 1/8，则一个SSB映射8个PRACH occasion)，且R个连续索引的preamble映射到SSB n？？？？ 下面的例子应该能回答这个问题。
每个SSB占有的preamble不一样吗？每个ssb占有的preambe数怎么确定？
一个prach occasion占有多少个prach preamble?&nbsp; ===每个ssb占有的preambe数*每个prach occasion占有的ssb数。
&nbsp;ssb-perRACH-OccasionAndCB-PreamblesPerSSB配下来两个参数：cbPreamblesPerSsb和ssbPerRachOccasion。
cbPreamblesPerRachOccasion = cbPreamblesPerSsb* max(1, ssbPerRachOccasion)
如果ssbPerRachOccasion<1， 假设是1/4，则一个SSB对应4个occasion，此时可以配置cbPreamblesPerSsb最大为64,cbPreamblesPerRachOccasion 等于64，每个occasion包含64个preamble，每个SSB对应4个occasion。<br>ssbPerRachOccasion假设是4， 则4个SSB对应1个prach occasion. 此时可以配置cbPreamblesPerSsb最大为16，cbPreamblesPerRachOccasion 也等于64， 每个occasion包含64个preamble,对应4个SSB. SSB0里面的preamble index是从0-15，SSB1里面的preamble index是从16-31，SSB2里面的preamble index是从32-47，SSB3里面的preamble index是从48-63？
&nbsp;
https://blog.csdn.net/qq_33206497/article/details/90415621------这是上面的一个综合。
https://blog.csdn.net/GYK0812/article/details/93490239----随机接入 -MSG1