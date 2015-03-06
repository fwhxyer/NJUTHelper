//
//  OurSchoolViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "OurSchoolViewController.h"
#import "OurSchoolDetailViewController.h"

@interface OurSchoolViewController (){
    NSMutableArray *title;
    NSMutableArray *detail;
    NSMutableArray *photo;
    NSInteger indexSelected;
}

@end

@implementation OurSchoolViewController
@synthesize mainView;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GetOurSchoolDetail"])
    {
        OurSchoolDetailViewController *ourSchool=segue.destinationViewController;
        ourSchool.navigationItem.title = [title objectAtIndex:indexSelected];
        UIImage *tmpImage=[UIImage imageNamed:[photo objectAtIndex:indexSelected]];
        ourSchool.tmpPhoto = tmpImage;
        NSString *tmp=[[NSString alloc]initWithString:[detail objectAtIndex:indexSelected]];
        NSRange tmpRange=[tmp rangeOfString:@"："];
        tmp=[tmp substringFromIndex:tmpRange.location+tmpRange.length];
        ourSchool.tmpDetail = tmp;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView.backgroundColor = [UIColor underPageBackgroundColor];
    
    [self allDataInit];
}

-(IBAction)back:(id)sender{
    [self.delegate ourSchoolViewControllerDidBack:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [detail count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"江浦校区";
        default:
            return @"未知分组";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"OurSchoolCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text=[title objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexSelected = indexPath.row;
    return indexPath;
}

-(void)allDataInit{
    detail = [[NSMutableArray alloc]initWithObjects:nil];
    title = [[NSMutableArray alloc]initWithObjects:nil];
    photo = [[NSMutableArray alloc]initWithObjects:nil];
    [self detailInit];
    [self titleInit];
    [self photoInit];
}

-(void)photoInit{
    for (int i=0;i<[title count];i++){
        NSString *tmp=[[NSString alloc]initWithFormat:@"sc%d.jpg",i];
        [photo addObject:tmp];
    }
}

-(void)titleInit{
    for (int i=0; i<[detail count]; i++) {
        NSRange tmpRange=[[detail objectAtIndex:i]rangeOfString:@"："];
        NSString *tmp=[[NSString alloc]initWithString:[detail objectAtIndex:i]];
        tmp=[tmp substringToIndex:tmpRange.location];
        [title addObject:tmp];
    }
    
}

-(void)detailInit{
    NSString *tmp;
    
    tmp= [[NSString alloc]initWithFormat:@"厚学楼：主要教学楼之一，大厅是新生报名的主要场所。学校为了喜迎校庆，特在3楼以下的大教室添置立式空调。对面是校车站台。朝校门方向步行百步即可抵达校园巴士始发点。需要阳光晨跑的童鞋7点20前务必在此等车！童鞋，如果你还相信爱情，如果你还在期待走廊上的美丽邂逅，那就来厚学楼吧。如果你想在教室里冬天不挨冻，夏天不被烤，那就来厚学楼吧。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"明德楼：工大行政集中营。更是学生组织：社联、青协、科协、广播台的资深老巢。补办饭卡学生证什么的同学别跑错地，就这儿。此楼与学生没太大关系，以前只有去堕落街的时候才会偶经此地。然自阳光长跑在此设点以来，每天都人来人往、络绎不绝，少则排平行直线形队伍，多则排S形、回字形。。。形态各异、惨不忍看！"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"沉毅楼：该实验楼以其宏伟壮观的沉毅广场和历史悠久的沉毅大鼎闻名于工大。陈毅广场乃开学“百团大战”的主战场兼轮滑社的训练基地。实验之前，必拜神鼎。当你置身于神鼎之前，45度角仰瞻其后近乎哥特式风格的神楼，清晨的阳光透过玻璃斜洒下来，白鸽在你身边围绕，那么恭喜你，神已经改写你的实验结果了。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"笃行楼：南工大生工实验中心。更是机房重地，有网速慢、游戏多、没就下、跑得动的特点。如果你想玩机房的各大游戏，那就来笃行楼看人体器官标本吧。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"同和楼：同和是栋神奇的教学楼，前是工大校车始发点，后有阳光长跑指纹机。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"仁智楼：仁智有两条天路，一条是通往天宝阁的台阶，一条是楼旁那陡坡。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"地坤天工：都是南工大实验基地。不同的是：地坤乃测绘院老巢所在，后山乃工大“打野圣地”。因为天工的机房5毛一小时，所以和大图的网速一样蛋疼。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"语音楼：当计算机中心还在面向全体学子玩集体的时候，外语中心早已被外国语学院攻占下，外院学子称霸语音楼，从不带鞋套。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"AB楼：工大学子一直搞不明白，明明有A B C三栋楼，却只叫前两楼的名字。去空调教室通宵的时候请自备粮食和外套。去了C楼，同学之间这样问候道：今天你带鞋套了吗？"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"老南苑：能够闻到“工大鱿鱼”的刺激性气味。离堕落街最近的宿舍，尽管是咫尺天涯。沿河的小户型，低密度——方圆百里就这一家！"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"新南苑：从萌正太蜕变成工大招牌儿狼的修炼圣地。采光度高，易暴露，路人对穿着裤衩在阳台上荡漾的男纸习以为常。就其新建的篮球场来看，南工大真理就是——有男人在的地方就有球场。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"北苑：藏匿于西苑后山深处，临近同心湖，依山傍水、远离闹市喧嚣、尽享静谧人生，是一个影响你世界观的原生态文化住宅。这里住着一群缺女人缺滋润的老男孩。他们总在期待着保研路上能发生点什么，好让自己英雄救美。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"东苑：与北苑一样缺少滋润，所以东苑的男人永远无法成为大湿。你听说过“东苑寂寞门”吗？兄弟别想歪，不是门事件，而是那扇左半边有“寂”，右半边有“寞”的东苑后门。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"西苑：南工大妹子集聚地。西苑，那是一个眼里全是女人的工大极乐世界。在这片沃土上我们又一次相信了爱情，因为——看看美女真的会怀孕。去过西苑却没有心神不宁、惦记酸梅汤、因妒忌情侣而呕吐等症状的男纸，不是南工大的好儿狼。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"桂苑：人称“停尸房”。不过地理位置很优越，除了楼下的小店有些坑爹。“桂苑也是个好地方，北傍孔雀园，南邻音乐台，方圆300米内就有4个食堂。其实最重要的是桂苑离西苑最近。”——摘自《南工大一百条》"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"象山：传说从校门口步行至此需一节课，也是校园巴士的终点站。有个闻名全校的坑爹食堂，同学经过时都绕着走。象山男与于北苑男的区别在于：北苑男深居简出、内敛低调，而象山男热情奔放、基情四射。勇敢的男人们，在世界杯期间曾为亮灯而战，虽然没有任何效果。象山男子伤不起。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"檀香：如果说西苑是美女展示厅，那檀香则是工大深闺。与象山苑仅一铁门相隔，因此成了男人的天堂。铁门是阻挡不了热情的，正如宿管阻止不了象山水榭淘来的违禁品。“檀香前面有五张椅子，如果你晚上一个人坐在那里，会显得与周围环境格格不入，多数人会觉得，你失恋了……”——摘自《南工大一百条》"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"浦江：南工大五星级豪华宿舍：独立卫生间、独立浴室、独立烧水、直达电梯、豪华洗衣房。更有男女混住的鸳鸯楼闻名全校。不亚于象山人民，浦江人民曾因“热水门”事件轰动于各大网络平台。现场直播哦亲！"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"音乐台：疑似天坑，一般举办院系晚会和乐队演出。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"大活：条件简陋，209批不到经费时的必选之地，活动随便搞。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"浦报：工大目前仅次于体育馆的活动场地，大型晚会首选地。当然，租金也不便宜。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"图报：以大型讲座为主，【明德大讲堂】的主要场地。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"厚报：舞台效果良好，座位不多，适合量少而精的的活动。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"逸夫图书馆：人称“大图”，坐落于江浦校区中心位置。虽然拥有现代新颖的立面造型、功能完备的平面布局，但这着实不是浪漫之地，因为你再也遇不上这样一个人，微笑着对她说：嘿！这是你的橡皮吗？对方回眸道：不，是你的橡皮。这样的遗憾就好像多媒体阅览室凝望着对面的机房，却迈不出一步。言下之意就是：一月的窗户挡的不是寒风，是蛋疼；六月的四楼吹的不是冷气，是菊紧。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"浦江图书馆：人称“小图”，藏在C楼某个阴暗角落。麻雀虽小五脏俱全，毕竟不让人上厕所的厕所不是哪都有的。因为手机信号差的可以自动关机了，所以领导觉得有必要将无线网速提高百倍了。通向二楼的那个楼梯间其实是为情侣搭建的，隐蔽性好、警惕度高，所以你们懂了吗？"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"天宝阁：校史陈列室。人称“水塔”。据风水学解释，南工大多木易生火，需以水克之，故称水塔。此塔不仅外形别具内涵，而且疑似模仿埃菲尔铁塔的斜度。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"镜湖：南工大占地面积最大的内陆湖。镜湖是个好同志，虽然湖水浑浊略带鱼腥味，但是咱们喷得高飘得远啊！镜湖姐姐赫然成为南工大不朽的神话，续写着“三缺一”的传奇。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"溢清同济湖：简称“同济湖”。一架圆弧形木桥营造了一片别具特色、特色中不乏清新、清新中略带洋气、洋气中伴有乡野、乡野中侧漏霸气的转角风光。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"如岸咖啡厅：看着菜单每样都想来一份，来几次后才发现各种饭菜都一个味道。二楼有包厢，更确切地说是情侣套间。舞台上有块幕布，服务员们常在下午围着看韩剧。而那些三两拼凑的桌椅更是为杀人游戏爱好者和三国杀迷们提供了良好场所。别忘了带耳机，因为如岸那位叔总爱在黄金时段放《终于你做了别人的小三》。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"南苑商业街：工大小商贩和工大创业人士集聚地之一。水果店的招牌不是水果，而是那长得有些抽象的吵死人的女儿。更抽象的“成妈妈旅游”寄居数码店，并在隔壁的讯投科技租到了一块不要钱的白板。面包店的老板喜欢在晚上凑一桌争上游，卖大肉包的老板娘爱十字绣。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"东苑商业街：商业街不咋地，坑爹的促销活动倒是很多。学校大型零售超市深藏于东一食堂。学长的生意还是要捧捧场滴，期中有旧书清仓甩卖，期末还有南京特产销售。唯一能勾起雅兴的还数初春时节，杂货店的老板贩卖一些小盆栽，虽然不算贵，但也活不长啊亲。对了，学长建议买烟不要去东苑，兼职可以来转转。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"北苑商业街：内设农行取款机构，败笔就是整条街都赤果果地裸露在光天化日之下，排长队取钱的孩纸不能避雨也没地遮阳。水果摊倚仗其得天独厚的地理优势称霸了北苑，经营妥当，合理奸商。只是那北苑超市，不让刷卡也就算了，货架上还找不到华尔街。虽说北苑附近都是健壮青年，好歹也要照顾一下同和仁智上课的妹子吧。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"象山水榭：有卖各种宿舍违禁物品，象山人民深受食堂摧残给这店带来了无限商机。比如面包房、周黑鸭、还有10块一次的理发店。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"校体育馆：全校档次最高的活动场所。成功举办了校庆晚会、浦口区红歌赛、毕业生晚会等多次大型演出。负一楼的健身房不出意外的话还是会一直坚挺的，虽然网上称那下面藏着南工大，不，是中国最神秘的EVA初号机。后面新开的游泳馆起了个特霸气的名字——五台山游泳馆江北馆。想要进去看美女的男纸请带好泳裤，谢谢。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"浦江操场：一个工大学子与此的缘分大致是这样的。大一：军训、校运动会；大二：校运动会；大三：校运动会；大四：拍毕业照、毕业典礼。浦江篮球场最大的亮点不是塑胶地，也不是铁围网，而是晚上能撑起半边天的巨型照明灯，这是东苑人民一直所向往却无法实现的。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"垒球场：依山傍水，巧妙利用地形地貌，把现代建筑与自然景观巧妙地合二为一。“我参加了23次世锦赛和奥运会，这么漂亮的场地我还是第一次看到。”这是国际垒联秘书长安德鲁先生的感叹。来自中国台北的国际奥委会委员吴经国见此场地也连声称赞：“世界上再也找不出比这更好的垒球场了。”——摘自百度"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"网球场：位于东苑下面大概有20个场，规模庞大，是一个很好的运动场地。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"象山长廊：长廊好长好长好长好长，没走过的童鞋一定要走一走。直连象山的交通干线，经常会有互不相识的男女生面对面走过，然后双方如沐春风，然后成就一段鸳鸯情缘。"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"去新街口常用路线：汉江线：龙华广场到盐仓桥（经大桥）转100，或者到汉中门转地铁2号线（汉江线分两种，其中的区间车不到汉中门）\n浦新线：龙华广场到兴隆大街（经隧道）转地铁2号线\nD7线：阅景龙华到兴隆大街（经隧道）转地铁2号线"];
    [detail addObject:tmp];
    tmp= [[NSString alloc]initWithFormat:@"玩转南京攻略：http://bbs.njut.edu.cn/thread-11518-1-1.html\nhttp://bbs.njut.edu.cn/thread-1791-1-1.html"];
    [detail addObject:tmp];
}

@end
