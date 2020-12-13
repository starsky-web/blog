本系列博客介绍以python+pygame库进行小游戏的开发。有写的不对之处还望各位海涵。
&nbsp;
前几期博客我们一起学习了，pygame中的<a href="http://www.cnblogs.com/msxh/p/5027688.html" target="_blank">冲突检测技术</a>以及一些<a href="http://www.cnblogs.com/msxh/p/5040483.html" target="_blank">常用的数据结构</a>。
这次我们来一起做一个简单的酷跑类游戏综合运用以前学到的知识。
程序下载地址：<a href="https://pan.baidu.com/s/1Ji2Ubsds6z2brBx8Gz1OOw%20" target="_blank">https://pan.baidu.com/s/1Ji2Ubsds6z2brBx8Gz1OOw&nbsp;</a>提取码：dff4&nbsp;
源代码网盘地址：<a href="https://pan.baidu.com/s/1T7tlYbTNUPRhtJ45B6PAPw" target="_blank">https://pan.baidu.com/s/1T7tlYbTNUPRhtJ45B6PAPw</a>&nbsp;&nbsp;提取码：mhip&nbsp;
github地址：<a href="https://github.com/XINCGer/catRunFast" target="_blank">https://github.com/XINCGer/catRunFast</a>
效果图：
<img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214124841365-831950089.png" alt="" width="426" height="331"><img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214124846943-731803581.png" alt="" width="424" height="331"><img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214124855756-2108065097.png" alt="" width="428" height="336"><img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214124901177-493275961.png" alt="" width="420" height="324"><img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214124905318-1653104765.png" alt="" width="403" height="318">
&nbsp;
现在我们来分析一下制作流程：
游戏中一共有嗷大喵，恶龙，火焰，爆炸动画和果实（就是上方蓝色的矩形块）这几种精灵。这里我们使用到了前几期博客中的MyLibrary.py。上述这几个精灵都是&nbsp;MySprite类实例化的对象。
为了方便管理。我们建立了几个精灵组，并且将一些精灵塞到了里面：
```python
#创建精灵组
group = pygame.sprite.Group()
group_exp = pygame.sprite.Group()
group_fruit = pygame.sprite.Group()
#创建怪物精灵
dragon = MySprite()
dragon.load("dragon.png", 260, 150, 3)
dragon.position = 100, 230
group.add(dragon)

#创建爆炸动画
explosion = MySprite()
explosion.load("explosion.png",128,128,6)
#创建玩家精灵
player = MySprite()
player.load("sprite.png", 100, 100, 4)
player.position = 400, 270
group.add(player)

#创建子弹精灵
arrow = MySprite()
arrow.load("flame.png", 40, 16, 1)
arrow.position = 800,320
group.add(arrow)
```
&nbsp;
在程序开始的时候我们可以看到有一个欢迎界面，为了简单我这里是直接在ps里面做好了图片，然后加载到程序中的：
```python
interface = pygame.image.load("interface.png")
```
界面上面还有一个按钮，当鼠标经过的时候，会变成灰底的，因此我们设计一个button类：
简单来说就是预先加载一张正常状态下在的button图片和一个按下状态的button图片，然后判断鼠标的pos是否和button的位置有重合，如果有则显示button被按下时的图片。
关于button的设计我参考了这位博友的教程：<a href="http://www.cnblogs.com/SRL-Southern/p/4949624.html" target="_blank">http://www.cnblogs.com/SRL-Southern/p/4949624.html</a>，他的教程写的非常不错。
```python
#定义一个按钮类
class Button(object):
    def __init__(self, upimage, downimage,position):
        self.imageUp = pygame.image.load(upimage).convert_alpha()
        self.imageDown = pygame.image.load(downimage).convert_alpha()
        self.position = position
        self.game_start = False
        
    def isOver(self):
        point_x,point_y = pygame.mouse.get_pos()
        x, y = self. position
        w, h = self.imageUp.get_size()

        in_x = x - w/2 < point_x < x + w/2
        in_y = y - h/2 < point_y < y + h/2
        return in_x and in_y

    def render(self):
        w, h = self.imageUp.get_size()
        x, y = self.position
        
        if self.isOver():
            screen.blit(self.imageDown, (x-w/2,y-h/2))
        else:
            screen.blit(self.imageUp, (x-w/2, y-h/2))
    def is_start(self):
        if self.isOver():
            b1,b2,b3 = pygame.mouse.get_pressed()
            if b1 == 1:
                self.game_start = True
                bg_sound.play_pause()
                btn_sound.play_sound()
                bg_sound.play_sound()
```
可以看到这个button类里面我还添加了一个isStart的方法，他是用来判断是否开始游戏的。当鼠标的位置与button重合，且按下鼠标左键的时候，游戏就开始。
（将game_start变量置为True）然后通过btn_sound.play_sound()， bg_sound.play_sound() &nbsp;这两句来播放按钮被按下的声音和游戏的背景音乐。
关于pygame中声音的操作，我稍后介绍一下。
&nbsp;
可以看到程序中还有一个不停滚动的地图，让我们来实现这个滚动地图类：
```python
#定义一个滚动地图类
class MyMap(pygame.sprite.Sprite):
    
    def __init__(self,x,y):
        self.x = x
        self.y = y
        self.bg = pygame.image.load("background.png").convert_alpha()
    def map_rolling(self):
        if self.x < -600:
            self.x = 600
        else:
            self.x -=5
    def map_update(self):
        screen.blit(self.bg, (self.x,self.y))
    def set_pos(x,y):
        self.x =x
        self.y =y
```
创建两个地图对象：
```python
#创建地图对象
bg1 = MyMap(0,0)
bg2 = MyMap(600,0)
```
在程序中直接调用update和rolling方法就可以让地图无限的滚动起来了。
```python
bg1.map_update()
bg2.map_update()
bg1.map_rolling()
bg2.map_rolling()
```
你看明白这个无限滚动地图是如何工作的了吗。首先渲染两张地图背景，一张展示在屏幕上面，一张在屏幕之外预备着（我们暂时看不到），如下图所示：
<img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214181423349-1576229244.png" alt="" width="577" height="297">
然后两张地图一起以相同的速度向左移动：
<img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214181540662-110747343.png" alt="" width="599" height="291">
当地图1完全离开屏幕范围的时候，再次将它的坐标置为600，0(这样就又回到了状态1)：
<img src="https://images2015.cnblogs.com/blog/798142/201512/798142-20151214181642927-2137530979.png" alt="" width="535" height="290">
这样通过两张图片的不断颠倒位置，然后平移，在我们的视觉中就形成了一张不断滚动的地图了。
&nbsp;
下面介绍一下如何在pygame中加载并且使用声音：
1.初始化音频模块：
我们要使用的音频系统包含在了pygame的pygame.mixer模块里面。因此在使用音频之前要初始化这个模块：
```python
pygame.mixer.init()
```
这个初始化模块语句在程序中执行一次就好。
2.加载音频文件：
使用的是pygame.mixer.Sound类来加载和管理音频文件，pygame支持两种音频文件：未压缩的WAV和OGG音频文件，如果要播放长时间的音乐，我推荐你使用OGG格式音频文件，因为它的体积比较小，适合长时间的加载和播放。当你要播放比较短的音频的时候可以选择WAV。
```python
hit_au = pygame.mixer.Sound("exlposion.wav")
```
3.播放音乐：
上面的pygame.mixer.Sound函数返回了一个sound对象，我们可以使用play和stop方法来播放和停止播放音乐。
但是这里我们介绍一种更为高级的用法，使用pygame.mixer.Channel，这个类提供了比sound对象更为丰富的功能。
首先我们先申请一个可用的音频频道：
```python
channel = pygame.mixer.find_channel(True)
```
一旦有了频道之后我们就可以使用Channel.play()方法来播放一个sound对象了。
```python
channel.play(sound)
```
&nbsp;
好了现在让我们来实现一下和音频有关的模块：
首先定义一个初始化的函数，它初始化了音频模块，并且加载了一些音频文件以方便我们在程序中使用：
```python
def audio_init():
    global hit_au,btn_au,bg_au,bullent_au
    pygame.mixer.init()
    hit_au = pygame.mixer.Sound("exlposion.wav")
    btn_au = pygame.mixer.Sound("button.wav")
    bg_au = pygame.mixer.Sound("background.ogg")
    bullent_au = pygame.mixer.Sound("bullet.wav")
```
然后我们实现了一个Music类，这个类可以控制声音的播放和暂停（set_volume函数是用来设置音乐声音大小的）：
```python
class Music():
    def __init__(self,sound):
        self.channel = None
        self.sound = sound     
    def play_sound(self):
        self.channel = pygame.mixer.find_channel(True)
        self.channel.set_volume(0.5)
        self.channel.play(self.sound)
    def play_pause(self):
        self.channel.set_volume(0.0)
        self.channel.play(self.sound)
```
&nbsp;
跳跃函数：
当按下空格键的时候，嗷大喵会跳起，这个是如何实现的呢？
```python
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
    keys = pygame.key.get_pressed()
    if keys[K_ESCAPE]:
        pygame.quit()
        sys.exit()
        
    elif keys[K_SPACE]:
        if not player_jumping:
            player_jumping = True
            jump_vel = -12.0
```
当按下空格键的时候，会将player_jumping变量置为True 并且给jump_vel一个初速度-12.0
然后在每次循环的时候，将jump_vel 加0.6，当嗷大喵回到起跳位置的时候，将速度置为0，使人物不再在y方向上有移动。
&nbsp;
```python
            #检测玩家是否处于跳跃状态
            if player_jumping:
                if jump_vel <0:
                    jump_vel += 0.6
                elif jump_vel >= 0:
                    jump_vel += 0.8
                player.Y += jump_vel
                if player.Y > player_start_y:
                    player_jumping = False
                    player.Y = player_start_y
                    jump_vel = 0.0
```
&nbsp;
然后我们还需要一个不断发出的子弹：
```python
#更新子弹
            if not game_over:
                arrow.X -= arrow_vel
            if arrow.X < -40: reset_arrow()
```
```python
#重置火箭函数
def reset_arrow():
    y = random.randint(270,350)
    arrow.position = 800,y
    bullent_sound.play_sound()
```
&nbsp;
关于嗷大喵和子弹冲突检测我们使用了之前学过的矩形冲突检测技术，当玩家和子弹产生冲突的时候，重置子弹，播放爆炸动画，然后将人物的x坐标值向左移动10，以表示人物受到伤害。恶龙和子弹的冲突和这个是一样的，这里就不再赘述了。
```python
#碰撞检测，子弹是否击中玩家
            if pygame.sprite.collide_rect(arrow, player):
                reset_arrow()
                explosion.position =player.X,player.Y
                player_hit = True
                hit_sound.play_sound()
                if p_first:
                    group_exp.add(explosion)
                    p_first = False
                player.X -= 10
```
然后我们还需要考虑一下玩家被恶龙追上的时候的情形，还是应用矩形检测技术：
```python
            if pygame.sprite.collide_rect(player, dragon):
                game_over = True
```
&nbsp;
为了使果实移动，我们需要遍历group_fruit里面的果实，然后依次将他们左移5个单位，然后我们还需要判断玩家吃到果实的场景，果实会消失，然后玩家的积分增加。
这里使用了之前学过的pygame.sprite.spritecollide(sprite,sprite_group,bool)。
调用这个函数的时候，一个组中的所有精灵都会逐个地对另外一个单个精灵进行冲突检测，发生冲突的精灵会作为一个列表返回。
这个函数的第一个参数就是单个精灵，第二个参数是精灵组，第三个参数是一个bool值，最后这个参数起了很大的作用。当为True的时候，会删除组中所有冲突的精灵，False的时候不会删除冲突的精灵。因此我们这里将第三个参数设置为True，这样就会删除掉和精灵冲突的对象了，看起来就好像是玩家吃掉了这些果实一样。
```python
#遍历果实，使果实移动
            for e in group_fruit:
                e.X -=5
            collide_list = pygame.sprite.spritecollide(player,group_fruit,False)
            score +=len(collide_list)
```
&nbsp;
最后还是看一下全部的代码：
```python
  1 # -*- coding: utf-8 -*-
  2 import sys, time, random, math, pygame,locale
  3 from pygame.locals import *
  4 from MyLibrary import *
  5 
  6 #重置火箭函数
  7 def reset_arrow():
  8     y = random.randint(270,350)
  9     arrow.position = 800,y
 10     bullent_sound.play_sound()
 11 
 12 #定义一个滚动地图类
 13 class MyMap(pygame.sprite.Sprite):
 14     
 15     def __init__(self,x,y):
 16         self.x = x
 17         self.y = y
 18         self.bg = pygame.image.load("background.png").convert_alpha()
 19     def map_rolling(self):
 20         if self.x < -600:
 21             self.x = 600
 22         else:
 23             self.x -=5
 24     def map_update(self):
 25         screen.blit(self.bg, (self.x,self.y))
 26     def set_pos(x,y):
 27         self.x =x
 28         self.y =y
 29 #定义一个按钮类
 30 class Button(object):
 31     def __init__(self, upimage, downimage,position):
 32         self.imageUp = pygame.image.load(upimage).convert_alpha()
 33         self.imageDown = pygame.image.load(downimage).convert_alpha()
 34         self.position = position
 35         self.game_start = False
 36         
 37     def isOver(self):
 38         point_x,point_y = pygame.mouse.get_pos()
 39         x, y = self. position
 40         w, h = self.imageUp.get_size()
 41 
 42         in_x = x - w/2 < point_x < x + w/2
 43         in_y = y - h/2 < point_y < y + h/2
 44         return in_x and in_y
 45 
 46     def render(self):
 47         w, h = self.imageUp.get_size()
 48         x, y = self.position
 49         
 50         if self.isOver():
 51             screen.blit(self.imageDown, (x-w/2,y-h/2))
 52         else:
 53             screen.blit(self.imageUp, (x-w/2, y-h/2))
 54     def is_start(self):
 55         if self.isOver():
 56             b1,b2,b3 = pygame.mouse.get_pressed()
 57             if b1 == 1:
 58                 self.game_start = True
 59                 bg_sound.play_pause()
 60                 btn_sound.play_sound()
 61                 bg_sound.play_sound()
 62 
 63 def replay_music():
 64     bg_sound.play_pause()
 65     bg_sound.play_sound()
 66 
 67 #定义一个数据IO的方法
 68 def data_read():
 69     fd_1 = open("data.txt","r")
 70     best_score = fd_1.read()
 71     fd_1.close()
 72     return best_score
 73 
 74    
 75 #定义一个控制声音的类和初始音频的方法
 76 def audio_init():
 77     global hit_au,btn_au,bg_au,bullent_au
 78     pygame.mixer.init()
 79     hit_au = pygame.mixer.Sound("exlposion.wav")
 80     btn_au = pygame.mixer.Sound("button.wav")
 81     bg_au = pygame.mixer.Sound("background.ogg")
 82     bullent_au = pygame.mixer.Sound("bullet.wav")
 83 class Music():
 84     def __init__(self,sound):
 85         self.channel = None
 86         self.sound = sound     
 87     def play_sound(self):
 88         self.channel = pygame.mixer.find_channel(True)
 89         self.channel.set_volume(0.5)
 90         self.channel.play(self.sound)
 91     def play_pause(self):
 92         self.channel.set_volume(0.0)
 93         self.channel.play(self.sound)
 94       
 95 #主程序部分
 96 pygame.init()
 97 audio_init()
 98 screen = pygame.display.set_mode((800,600),0,32)
 99 pygame.display.set_caption("嗷大喵快跑！")
100 font = pygame.font.Font(None, 22)
101 font1 = pygame.font.Font(None, 40)
102 framerate = pygame.time.Clock()
103 upImageFilename = 'game_start_up.png'
104 downImageFilename = 'game_start_down.png'
105 #创建按钮对象
106 button = Button(upImageFilename,downImageFilename, (400,500))
107 interface = pygame.image.load("interface.png")
108 
109 #创建地图对象
110 bg1 = MyMap(0,0)
111 bg2 = MyMap(600,0)
112 #创建一个精灵组
113 group = pygame.sprite.Group()
114 group_exp = pygame.sprite.Group()
115 group_fruit = pygame.sprite.Group()
116 #创建怪物精灵
117 dragon = MySprite()
118 dragon.load("dragon.png", 260, 150, 3)
119 dragon.position = 100, 230
120 group.add(dragon)
121 
122 #创建爆炸动画
123 explosion = MySprite()
124 explosion.load("explosion.png",128,128,6)
125 #创建玩家精灵
126 player = MySprite()
127 player.load("sprite.png", 100, 100, 4)
128 player.position = 400, 270
129 group.add(player)
130 
131 #创建子弹精灵
132 arrow = MySprite()
133 arrow.load("flame.png", 40, 16, 1)
134 arrow.position = 800,320
135 group.add(arrow)
136 
137 
138 
139 #定义一些变量
140 arrow_vel = 10.0
141 game_over = False
142 you_win = False
143 player_jumping = False
144 jump_vel = 0.0
145 player_start_y = player.Y
146 player_hit = False
147 monster_hit = False
148 p_first = True
149 m_first = True
150 best_score = 0
151 global bg_sound,hit_sound,btn_sound,bullent_sound
152 bg_sound=Music(bg_au)
153 hit_sound=Music(hit_au)
154 btn_sound=Music(btn_au)
155 bullent_sound =Music(bullent_au)
156 game_round = {1:'ROUND ONE',2:'ROUND TWO',3:'ROUND THREE',4:'ROUND FOUR',5:'ROUND FIVE'}
157 game_pause = True
158 index =0
159 current_time = 0
160 start_time = 0
161 music_time = 0
162 score =0
163 replay_flag = True
164 #循环
165 bg_sound.play_sound()
166 best_score = data_read()
167 while True:
168     framerate.tick(60)
169     ticks = pygame.time.get_ticks()
170     for event in pygame.event.get():
171         if event.type == pygame.QUIT:
172             pygame.quit()
173             sys.exit()
174     keys = pygame.key.get_pressed()
175     if keys[K_ESCAPE]:
176         pygame.quit()
177         sys.exit()
178         
179     elif keys[K_SPACE]:
180         if not player_jumping:
181             player_jumping = True
182             jump_vel = -12.0
183             
184     screen.blit(interface,(0,0))
185     button.render()
186     button.is_start()
187     if button.game_start == True:
188         if game_pause :
189             index +=1
190             tmp_x =0
191             if score >int (best_score):
192                 best_score = score
193             fd_2 = open("data.txt","w+")
194             fd_2.write(str(best_score))
195             fd_2.close()
196             #判断游戏是否通关
197             if index == 6:
198                 you_win = True
199             if you_win:
200                 start_time = time.clock()
201                 current_time =time.clock()-start_time
202                 while current_time<5:
203                     screen.fill((200, 200, 200))
204                     print_text(font1, 270, 150,"YOU WIN THE GAME!",(240,20,20))
205                     current_time =time.clock()-start_time
206                     print_text(font1, 320, 250, "Best Score:",(120,224,22))
207                     print_text(font1, 370, 290, str(best_score),(255,0,0))
208                     print_text(font1, 270, 330, "This Game Score:",(120,224,22))
209                     print_text(font1, 385, 380, str(score),(255,0,0))
210                     pygame.display.update()
211                 pygame.quit()
212                 sys.exit()
213                 
214             for i in range(0,100):
215                 element = MySprite()
216                 element.load("fruit.bmp", 75, 20, 1)
217                 tmp_x +=random.randint(50,120)
218                 element.X = tmp_x+300
219                 element.Y = random.randint(80,200)
220                 group_fruit.add(element)
221             start_time = time.clock()
222             current_time =time.clock()-start_time
223             while current_time<3:
224                 screen.fill((200, 200, 200))
225                 print_text(font1, 320, 250,game_round[index],(240,20,20))
226                 pygame.display.update()
227                 game_pause = False
228                 current_time =time.clock()-start_time
229             
230         else:
231             #更新子弹
232             if not game_over:
233                 arrow.X -= arrow_vel
234             if arrow.X < -40: reset_arrow()
235             #碰撞检测，子弹是否击中玩家
236             if pygame.sprite.collide_rect(arrow, player):
237                 reset_arrow()
238                 explosion.position =player.X,player.Y
239                 player_hit = True
240                 hit_sound.play_sound()
241                 if p_first:
242                     group_exp.add(explosion)
243                     p_first = False
244                 player.X -= 10
245 
246             #碰撞检测，子弹是否击中怪物
247             if pygame.sprite.collide_rect(arrow, dragon):
248                 reset_arrow()
249                 explosion.position =dragon.X+50,dragon.Y+50
250                 monster_hit = True
251                 hit_sound.play_sound()
252                 if m_first:
253                     group_exp.add(explosion)
254                     m_first = False
255                 dragon.X -= 10
256 
257             #碰撞检测，玩家是否被怪物追上
258             if pygame.sprite.collide_rect(player, dragon):
259                 game_over = True
260             #遍历果实，使果实移动
261             for e in group_fruit:
262                 e.X -=5
263             collide_list = pygame.sprite.spritecollide(player,group_fruit,False)
264             score +=len(collide_list)
265             #是否通过关卡
266             if dragon.X < -100:
267                 game_pause = True
268                 reset_arrow()
269                 player.X = 400
270                 dragon.X = 100
271                 
272             
273 
274             #检测玩家是否处于跳跃状态
275             if player_jumping:
276                 if jump_vel <0:
277                     jump_vel += 0.6
278                 elif jump_vel >= 0:
279                     jump_vel += 0.8
280                 player.Y += jump_vel
281                 if player.Y > player_start_y:
282                     player_jumping = False
283                     player.Y = player_start_y
284                     jump_vel = 0.0
285 
286 
287             #绘制背景
288             bg1.map_update()
289             bg2.map_update()
290             bg1.map_rolling()
291             bg2.map_rolling()
292             
293             #更新精灵组
294             if not game_over:
295                 group.update(ticks, 60)
296                 group_exp.update(ticks,60)
297                 group_fruit.update(ticks,60)
298             #循环播放背景音乐
299             music_time = time.clock()
300             if music_time   > 150 and replay_flag:
301                 replay_music()
302                 replay_flag =False
303             #绘制精灵组
304             group.draw(screen)
305             group_fruit.draw(screen)
306             if player_hit or monster_hit:
307                 group_exp.draw(screen)
308             print_text(font, 330, 560, "press SPACE to jump up!")
309             print_text(font, 200, 20, "You have get Score:",(219,224,22))
310             print_text(font1, 380, 10, str(score),(255,0,0))
311             if game_over:
312                 start_time = time.clock()
313                 current_time =time.clock()-start_time
314                 while current_time<5:
315                     screen.fill((200, 200, 200))
316                     print_text(font1, 300, 150,"GAME OVER!",(240,20,20))
317                     current_time =time.clock()-start_time
318                     print_text(font1, 320, 250, "Best Score:",(120,224,22))
319                     if score >int (best_score):
320                         best_score = score
321                     print_text(font1, 370, 290, str(best_score),(255,0,0))
322                     print_text(font1, 270, 330, "This Game Score:",(120,224,22))
323                     print_text(font1, 370, 380, str(score),(255,0,0))
324                     pygame.display.update()
325                 fd_2 = open("data.txt","w+")
326                 fd_2.write(str(best_score))
327                 fd_2.close()
328                 pygame.quit()
329                 sys.exit()
330     pygame.display.update()
```
&nbsp;