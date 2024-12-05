µ7
8C:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Program.cs
	namespace 	
KTPS
 
. 
Server 
. 
WebAPI 
; 
public 
class 
Program 
{ 
public 

static 
void 
Main 
( 
string "
[" #
]# $
args% )
)) *
{ 
var 
builder 
= 
WebApplication $
.$ %
CreateBuilder% 2
(2 3
args3 7
)7 8
;8 9
builder!! 
.!! 
Services!! 
.!! 
AddControllers!! '
(!!' (
)!!( )
;!!) *
builder## 
.## 
Services## 
.## #
AddEndpointsApiExplorer## 0
(##0 1
)##1 2
;##2 3
builder$$ 
.$$ 
Services$$ 
.$$ 
AddSwaggerGen$$ &
($$& '
)$$' (
;$$( )
RegisterServices&& 
(&& 
builder&&  
.&&  !
Services&&! )
)&&) *
;&&* +
var(( 
app(( 
=(( 
builder(( 
.(( 
Build(( 
(((  
)((  !
;((! "
app** 
.** 
UseCors** 
(** 
builder** 
=>** 
builder** &
.**& '
AllowAnyOrigin**' 5
(**5 6
)**6 7
.**7 8
AllowAnyMethod**8 F
(**F G
)**G H
.**H I
AllowAnyHeader**I W
(**W X
)**X Y
)**Y Z
;**Z [
if-- 

(-- 
app-- 
.-- 
Environment-- 
.-- 
IsDevelopment-- )
(--) *
)--* +
)--+ ,
{.. 	
app// 
.// 

UseSwagger// 
(// 
)// 
;// 
app00 
.00 
UseSwaggerUI00 
(00 
)00 
;00 
}11 	
app33 
.33 
UseHttpsRedirection33 
(33  
)33  !
;33! "
app55 
.55 
UseAuthorization55 
(55 
)55 
;55 
app88 
.88 
MapControllers88 
(88 
)88 
;88 
app:: 
.:: 
Run:: 
(:: 
):: 
;:: 
};; 
private== 
static== 
void== 
RegisterServices== (
(==( )
IServiceCollection==) ;
services==< D
)==D E
{>> 
services?? 
.?? 
AddSingleton?? 
<?? 
IRepository?? )
,??) *

Repository??+ 5
>??5 6
(??6 7
)??7 8
;??8 9
services@@ 
.@@ 
AddSingleton@@ 
<@@ #
IRegistrationRepository@@ 5
,@@5 6"
RegistrationRepository@@7 M
>@@M N
(@@N O
)@@O P
;@@P Q
servicesAA 
.AA 
AddSingletonAA 
<AA 
IUserRepositoryAA -
,AA- .
UserRepositoryAA/ =
>AA= >
(AA> ?
)AA? @
;AA@ A
servicesBB 
.BB 
AddSingletonBB 
<BB  
IRegistrationServiceBB 2
,BB2 3
RegistrationServiceBB4 G
>BBG H
(BBH I
)BBI J
;BBJ K
servicesCC 
.CC 
AddSingletonCC 
<CC 
IFriendsServiceCC -
,CC- .
FriendsServiceCC/ =
>CC= >
(CC> ?
)CC? @
;CC@ A
servicesDD 
.DD 
AddSingletonDD 
<DD 
IUserServiceDD *
,DD* +
UserServiceDD, 7
>DD7 8
(DD8 9
)DD9 :
;DD: ;
servicesEE 
.EE 
AddSingletonEE 
<EE $
IPasswordResetRepositoryEE 6
,EE6 7#
PasswordResetRepositoryEE8 O
>EEO P
(EEP Q
)EEQ R
;EER S
servicesFF 
.FF 
AddSingletonFF 
<FF 
IGroupsRepositoryFF /
,FF/ 0
GroupsRepositoryFF1 A
>FFA B
(FFB C
)FFC D
;FFD E
servicesGG 
.GG 
AddSingletonGG 
<GG #
IGroupMembersRepositoryGG 5
,GG5 6"
GroupMembersRepositoryGG7 M
>GGM N
(GGN O
)GGO P
;GGP Q
servicesHH 
.HH 
AddSingletonHH 
<HH 
IGuestsRepositoryHH /
,HH/ 0
GuestsRepositoryHH1 A
>HHA B
(HHB C
)HHC D
;HHD E
servicesII 
.II 
AddSingletonII 
<II #
INotificationRepositoryII 5
,II5 6"
NotificationRepositoryII7 M
>IIM N
(IIN O
)IIO P
;IIP Q
servicesJJ 
.JJ 
AddSingletonJJ 
<JJ 
IFriendsRepositoryJJ 0
,JJ0 1
FriendsRepositoryJJ2 C
>JJC D
(JJD E
)JJE F
;JJF G
servicesKK 
.KK 
AddSingletonKK 
<KK 
ILoginServiceKK +
,KK+ ,
LoginServiceKK- 9
>KK9 :
(KK: ;
)KK; <
;KK< =
servicesLL 
.LL 
AddSingletonLL 
<LL  
INotificationServiceLL 2
,LL2 3
NotificationServiceLL4 G
>LLG H
(LLH I
)LLI J
;LLJ K
servicesMM 
.MM 
AddSingletonMM 
<MM 
IGroupsServiceMM ,
,MM, -
GroupsServiceMM. ;
>MM; <
(MM< =
)MM= >
;MM> ?
servicesNN 
.NN 
AddSingletonNN 
<NN !
IItemMemberRepositoryNN 3
,NN3 4 
ItemMemberRepositoryNN5 I
>NNI J
(NNJ K
)NNK L
;NNL M
servicesOO 
.OO 
AddSingletonOO 
<OO 
IItemMembersServiceOO 1
,OO1 2
ItemMembersServiceOO3 E
>OOE F
(OOF G
)OOG H
;OOH I
servicesPP 
.PP 
AddSingletonPP 
<PP 
IItemsRepositoryPP .
,PP. /
ItemsRepositoryPP0 ?
>PP? @
(PP@ A
)PPA B
;PPB C
servicesQQ 
.QQ 
AddSingletonQQ 
<QQ 
IItemsServiceQQ +
,QQ+ ,
ItemsServiceQQ- 9
>QQ9 :
(QQ: ;
)QQ; <
;QQ< =
servicesRR 

.RR
 
AddSingletonRR 
<RR 
ICalculationServiceRR +
,RR+ ,
CalculationServiceRR- ?
>RR? @
(RR@ A
)RRA B
;RRB C
}SS 
}TT ∆
SC:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Controllers\ShoppingListController.cs
	namespace 	
KTPS
 
. 
Server 
. 
WebAPI 
. 
Controllers (
;( )
[ 

Controller 
, 
Route 
( 
$str #
)# $
]$ %
public 
class "
ShoppingListController #
{ 
private 
readonly	 
IItemsService 
_itemsService  -
;- .
private 
readonly	 
ICalculationService %
_calculationService& 9
;9 :
public "
ShoppingListController 
( 
IItemsService 
itemsService 
, 
ICalculationService 
calculationService (
) 
{ 
_itemsService 
= 
itemsService 
; 
_calculationService 
= 
calculationService *
;* +
} 
[ 
HttpPost 

(
 
$str 
) 
] 
public 
async 
Task 
< 
ServerResult 
>  
CreateItemAsync! 0
(0 1
CreateItemRequest1 B
requestC J
)J K
=>L N
awaitO T
_itemsServiceU b
.b c
CreateItemAsyncc r
(r s
requests z
)z {
;{ |
[ 
HttpPost 
( 
$str 
) 
] 
public   

async   
Task   
<   
ServerResult   "
>  " #
EditItemAsync  $ 1
(  1 2
EditItemRequest  2 A
request  B I
)  I J
=>  K M
await  N S
_itemsService  T a
.  a b
EditItemAsync  b o
(  o p
request  p w
)  w x
;  x y
["" 
HttpGet"" 	
(""	 

$str""
  
)""  !
]""! "
public## 
async## 
Task## 
<## 
ServerResult## 
<##  
IEnumerable##  +
<##+ ,
	ItemBasic##, 5
>##5 6
>##6 7
>##7 8
GetItemsAsync##9 F
(##F G
int##G J
groupId##K R
)##R S
=>##T V
await##W \
_itemsService##] j
.##j k"
GetGroupItemListAsync	##k Ä
(
##Ä Å
groupId
##Å à
)
##à â
;
##â ä
[%% 
HttpGet%% 	
(%%	 

$str%%
 !
)%%! "
]%%" #
public&& 
async&& 
Task&& 
<&& 
ServerResult&& 
>&&  
DeleteItemAsync&&! 0
(&&0 1
int&&1 4
itemId&&5 ;
)&&; <
=>&&= ?
await&&@ E
_itemsService&&F S
.&&S T
DeleteItemAsync&&T c
(&&c d
itemId&&d j
)&&j k
;&&k l
[(( 
HttpGet(( 	
(((	 

$str((
 "
)((" #
]((# $
public)) 
async)) 
Task)) 
<)) 
ServerResult)) 
<))  
CalculationResponse))  3
>))3 4
>))4 5
CalculateAsync))6 D
())D E
int))E H
groupId))I P
)))P Q
=>))R T
await))U Z
_calculationService))[ n
.))n o(
CalculateGroupExpensesAsync	))o ä
(
))ä ã
groupId
))ã í
)
))í ì
;
))ì î
}** Õ
SC:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Controllers\RegistrationController.cs
	namespace 	
KTPS
 
. 
Server 
. 
WebAPI 
. 
Controllers (
;( )
[		 

Controller		 
,		 
Route		 
(		 
$str		 
)		 
]		  
public

 
class

 "
RegistrationController

 #
{ 
private 
readonly  
IRegistrationService ) 
_registrationService* >
;> ?
public 
"
RegistrationController !
(! " 
IRegistrationService 
registrationService 0
) 	
{  
_registrationService 
= 
registrationService 2
;2 3
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (

StartAsync) 3
(3 4
[4 5
FromBody5 =
]= >$
RegistrationStartRequest? W
requestX _
)_ `
=>a c
awaitd i 
_registrationServicej ~
.~ #
StartRegistrationAsync	 ï
(
ï ñ
request
ñ ù
)
ù û
;
û ü
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (
	AuthAsync) 2
(2 3
[3 4
FromBody4 <
]< =#
RegistrationAuthRequest> U
requestV ]
)] ^
=>_ a
awaitb g 
_registrationServiceh |
.| }"
AuthRegistrationAsync	} í
(
í ì
request
ì ö
)
ö õ
;
õ ú
} À
SC:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Controllers\NotificationController.cs
	namespace		 	
KTPS		
 
.		 
Server		 
.		 
WebAPI		 
.		 
Controllers		 (
;		( )
[ 

Controller 
, 
Route 
( 
$str !
)! "
]" #
public 
class "
NotificationController #
{ 
private 
readonly  
INotificationService ) 
_notificationService* >
;> ?
public 
"
NotificationController !
(! " 
INotificationService 
notificationService 0
) 	
{  
_notificationService 
= 
notificationService 2
;2 3
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (
Create) /
(/ 0
[0 1
FromBody1 9
]9 :%
CreateNotificationRequest; T
requestU \
)\ ]
=>^ `
awaita f 
_notificationServiceg {
.{ |
CreateAsync	| á
(
á à
request
à è
)
è ê
;
ê ë
[ 
HttpGet 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
IEnumerable# .
<. /
Notification/ ;
>; <
>< =
>= >
List? C
(C D
intD G
userIdH N
)N O
=>P R
awaitS X 
_notificationServiceY m
.m n
	ListAsyncn w
(w x
userIdx ~
)~ 
;	 Ä
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
>" #
Login$ )
() *
[* +
FromBody+ 3
]3 4&
RespondNotificationRequest5 O
requestP W
)W X
=>Y [
await\ a 
_notificationServiceb v
.v w
RespondAsync	w É
(
É Ñ
request
Ñ ã
)
ã å
;
å ç
}"" ∑
LC:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Controllers\LoginController.cs
	namespace 	
KTPS
 
. 
Server 
. 
WebAPI 
. 
Controllers (
;( )
[		 

Controller		 
,		 
Route		 
(		 
$str		 
)		 
]		 
public

 
class

 
LoginController

 
{ 
private 
readonly 
ILoginService "
_loginService# 0
;0 1
public 

LoginController 
( 
ILoginService (
loginService) 5
)5 6
{ 
_loginService 
= 
loginService $
;$ %
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (
Login) .
(. /
[/ 0
FromBody0 8
]8 9
LoginRequest: F
requestG N
)N O
=>P R
awaitS X
_loginServiceY f
.f g

LoginAsyncg q
(q r
requestr y
)y z
;z {
[ 
HttpPost 
( 
$str  
)  !
]! "
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (
ForgotMyPassword) 9
(9 :
[: ;
FromBody; C
]C D!
ForgotPasswordRequestE Z
request[ b
)b c
=>d f
awaitg l
_loginServicem z
.z { 
ForgotPasswordAsync	{ é
(
é è
request
è ñ
)
ñ ó
;
ó ò
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
>" #
	ResetAuth$ -
(- .
[. /
FromBody/ 7
]7 8$
ResetPasswordAuthRequest9 Q
requestR Y
)Y Z
=>[ ]
await^ c
_loginServiced q
.q r#
ResetPasswordAuthAsync	r à
(
à â
request
â ê
)
ê ë
;
ë í
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
>" #
Reset$ )
() *
[* +
FromBody+ 3
]3 4 
ResetPasswordRequest5 I
requestJ Q
)Q R
=>S U
awaitV [
_loginService\ i
.i j
ResetPasswordAsyncj |
(| }
request	} Ñ
)
Ñ Ö
;
Ö Ü
} ¬.
MC:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Controllers\GroupsController.cs
	namespace

 	
KTPS


 
.

 
Server

 
.

 
WebAPI

 
.

 
Controllers

 (
;

( )
[ 

Controller 
, 
Route 
( 
$str 
) 
] 
public 
class 
GroupsController 
{ 
private 
readonly 
IGroupsService #
_groupsService$ 2
;2 3
public 

GroupsController 
( 
IGroupsService 
groupsService $
) 	
{ 
_groupsService 
= 
groupsService &
;& '
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (
NewAsync) 1
(1 2
[2 3
FromBody3 ;
]; <
NewGroupRequest= L
requestM T
)T U
=>V X
awaitY ^
_groupsService_ m
.m n
NewGroupAsyncn {
({ |
request	| É
)
É Ñ
;
Ñ Ö
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
>" #
	EditAsync$ -
(- .
[. /
FromBody/ 7
]7 8
EditGroupRequest9 I
requestJ Q
)Q R
=>S U
awaitV [
_groupsService\ j
.j k
EditGroupAsynck y
(y z
request	z Å
)
Å Ç
;
Ç É
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
>" #
DeleteAsync$ /
(/ 0
[0 1
FromBody1 9
]9 :
DeleteGroupRequest; M
requestN U
)U V
=>W Y
awaitZ _
_groupsService` n
.n o
DeleteGroupAsynco 
(	 Ä
request
Ä á
)
á à
;
à â
[!! 
HttpGet!! 
(!! 
$str!! "
)!!" #
]!!# $
public"" 

async"" 
Task"" 
<"" 
ServerResult"" "
<""" #
IEnumerable""# .
<"". /

GroupBasic""/ 9
>""9 :
>"": ;
>""; <
	ListAsync""= F
(""F G
int""G J
userId""K Q
)""Q R
=>""S U
await""V [
_groupsService""\ j
.""j k
GetGroupListAsync""k |
(""| }
userId	""} É
)
""É Ñ
;
""Ñ Ö
[$$ 
HttpPost$$ 
($$ 
$str$$ 
)$$ 
]$$  
public%% 

async%% 
Task%% 
<%% 
ServerResult%% "
>%%" #
RemoveMembersAsync%%$ 6
(%%6 7
[%%7 8
FromBody%%8 @
]%%@ A%
RemoveGroupMembersRequest%%B [
request%%\ c
)%%c d
=>%%e g
await%%h m
_groupsService%%n |
.%%| }$
RemoveGroupMembersAsync	%%} î
(
%%î ï
request
%%ï ú
)
%%ú ù
;
%%ù û
['' 
HttpGet'' 
('' 
$str''  
)''  !
]''! "
public(( 

async(( 
Task(( 
<(( 
ServerResult(( "
<((" ##
GetGroupMembersResponse((# :
>((: ;
>((; <
MemberListAsync((= L
(((L M
int((M P
groupId((Q X
)((X Y
=>((Z \
await((] b
_groupsService((c q
.((q r
GetMemberListAsync	((r Ñ
(
((Ñ Ö
groupId
((Ö å
)
((å ç
;
((ç é
[** 
HttpPost** 
(** 
$str** 
)** 
]** 
public++ 

async++ 
Task++ 
<++ 
ServerResult++ "
<++" #
int++# &
>++& '
>++' (
AddGuestAsync++) 6
(++6 7
[++7 8
FromBody++8 @
]++@ A
AddGuestRequest++B Q
request++R Y
)++Y Z
=>++[ ]
await++^ c
_groupsService++d r
.++r s
AddGuestAsync	++s Ä
(
++Ä Å
request
++Å à
)
++à â
;
++â ä
[-- 
HttpPost-- 
(-- 
$str-- 
)-- 
]-- 
public.. 

async.. 
Task.. 
<.. 
ServerResult.. "
>.." #
LeaveGroupAsync..$ 3
(..3 4
[..4 5
FromBody..5 =
]..= >
LeaveGroupRequest..? P
request..Q X
)..X Y
=>..Z \
await..] b
_groupsService..c q
...q r
LeaveGroupAsync	..r Å
(
..Å Ç
request
..Ç â
)
..â ä
;
..ä ã
[00 
HttpGet00 
(00 
$str00 
)00 
]00 
public11 

async11 
Task11 
<11 
ServerResult11 "
<11" #

GroupBasic11# -
>11- .
>11. /
GetGroupInfoAsync110 A
(11A B
int11B E
groupId11F M
)11M N
=>11O Q
await11R W
_groupsService11X f
.11f g
GetGroupInfoAsync11g x
(11x y
groupId	11y Ä
)
11Ä Å
;
11Å Ç
}22 ¸
NC:\Users\PC\Desktop\KTPS-2\KTPS.Server.WebAPI\Controllers\FriendsController.cs
	namespace		 	
KTPS		
 
.		 
Server		 
.		 
WebAPI		 
.		 
Controllers		 (
;		( )
[ 

Controller 
, 
Route 
( 
$str 
) 
] 
public 
class 
FriendsController 
{ 
private 
readonly 
IFriendsService $
_friendsService% 4
;4 5
public 

FriendsController 
( 
IFriendsService 
friendsService &
) 	
{ 
_friendsService 
= 
friendsService (
;( )
} 
[ 
HttpGet 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
IEnumerable# .
<. /
UserMinimal/ :
>: ;
>; <
>< =
FriendListAsync> M
(M N
intN Q
userIdR X
)X Y
=>Z \
await] b
_friendsServicec r
.r s
GetFriendListAsync	s Ö
(
Ö Ü
userId
Ü å
)
å ç
;
ç é
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
>" #
DeleteFriendAsync$ 5
(5 6
[6 7
FromBody7 ?
]? @
DeleteFriendRequestA T
requestU \
)\ ]
=>^ `
awaita f
_friendsServiceg v
.v w
DeleteFriendAsync	w à
(
à â
request
â ê
)
ê ë
;
ë í
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
ServerResult "
<" #
IEnumerable# .
<. /
UserMinimal/ :
>: ;
>; <
>< =
FindFriendAsync> M
(M N
[N O
FromBodyO W
]W X
FindFriendRequestY j
requestk r
)r s
=>t v
awaitw |
_friendsService	} å
.
å ç
FindFriendAsync
ç ú
(
ú ù
request
ù §
)
§ •
;
• ¶
} 