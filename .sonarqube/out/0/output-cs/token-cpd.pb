ï!
BC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\User\UserService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
User "
;" #
public		 
class		 
UserService		 
:		 
IUserService		 '
{

 
private 
readonly 
IUserRepository $
_userRepository% 4
;4 5
public 

UserService 
( 
IUserRepository 
userRepository &
) 	
{ 
_userRepository 
= 
userRepository (
;( )
} 
public 

async 
Task 
< 
bool 
> 
UsernameExistsAsync /
(/ 0
string0 6
username7 ?
)? @
{ 
var 
user 
= 
await 
_userRepository (
.( )
GetByUsernameAsync) ;
(; <
username< D
)D E
;E F
return 
user 
is 
not 
null 
;  
} 
public 

async 
Task 
< 
bool 
> 
EmailExistsAsync ,
(, -
string- 3
email4 9
)9 :
{ 
var 
user 
= 
await 
_userRepository (
.( )
GetByEmailAsync) 8
(8 9
email9 >
)> ?
;? @
return 
user 
is 
not 
null 
;  
} 
public   

async   
Task   
<   
int   
>   
CreateUserAsync   *
(  * +
RegistrationBasic  + <
registration  = I
)  I J
{!! 
return"" 
await"" 
_userRepository"" $
.""$ %
InsertAsync""% 0
(""0 1
new""1 4
(""4 5
)""5 6
{""7 8
Email""9 >
=""? @
registration""A M
.""M N
Email""N S
,""S T
Username""U ]
=""^ _
registration""` l
.""l m
Username""m u
,""u v
Password""w 
=
""Ä Å
registration
""Ç é
.
""é è
Password
""è ó
}
""ò ô
)
""ô ö
;
""ö õ
}## 
public%% 

async%% 
Task%% 
<%% 
	UserBasic%% 
>%%  "
GetUserByUsernameAsync%%! 7
(%%7 8
string%%8 >
username%%? G
)%%G H
{&& 
return'' 
await'' 
_userRepository'' $
.''$ %
GetByUsernameAsync''% 7
(''7 8
username''8 @
)''@ A
;''A B
}(( 
public** 

async** 
Task** 
<** 
	UserBasic** 
>**  
GetUserByEmailAsync**! 4
(**4 5
string**5 ;
email**< A
)**A B
{++ 
return,, 
await,, 
_userRepository,, $
.,,$ %
GetByEmailAsync,,% 4
(,,4 5
email,,5 :
),,: ;
;,,; <
}-- 
public// 

async// 
Task// 
<// 
	UserBasic// 
>//  
GetUserByIdAsync//! 1
(//1 2
int//2 5
id//6 8
)//8 9
{00 
return11 
await11 
_userRepository11 $
.11$ %
GetByIdAsync11% 1
(111 2
id112 4
)114 5
;115 6
}22 
public44 

async44 
Task44 
UpdateUserAsync44 %
(44% &
	UserBasic44& /
updatedUser440 ;
)44; <
{55 
await66 
_userRepository66 
.66 
UpdateUserAsync66 -
(66- .
updatedUser66. 9
)669 :
;66: ;
}77 
}88 Ø
CC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\User\IUserService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
User "
;" #
public 
	interface 
IUserService 
{ 
Task		 
<		 	
bool			 
>		 
UsernameExistsAsync		 "
(		" #
string		# )
username		* 2
)		2 3
;		3 4
Task

 
<

 	
bool

	 
>

 
EmailExistsAsync

 
(

  
string

  &
email

' ,
)

, -
;

- .
Task 
< 	
int	 
> 
CreateUserAsync 
( 
RegistrationBasic /
registration0 <
)< =
;= >
Task 
< 	
	UserBasic	 
> "
GetUserByUsernameAsync *
(* +
string+ 1
username2 :
): ;
;; <
Task 
< 	
	UserBasic	 
> 
GetUserByEmailAsync '
(' (
string( .
email/ 4
)4 5
;5 6
Task 
< 	
	UserBasic	 
> 
GetUserByIdAsync $
($ %
int% (
id) +
)+ ,
;, -
Task 
UpdateUserAsync	 
( 
	UserBasic "
updatedUser# .
). /
;/ 0
} ◊,
RC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Registration\RegistrationService.cs
	namespace

 	
KTPS


 
.

 
Model

 
.

 
Services

 
.

 
Registration

 *
;

* +
public 
class 
RegistrationService  
:! " 
IRegistrationService# 7
{ 
private 
readonly 
IUserService !
_userService" .
;. /
private 
readonly #
IRegistrationRepository ,#
_registrationRepository- D
;D E
public 

RegistrationService 
( 
IUserService 
userService  
,  !#
IRegistrationRepository	  "
registrationRepository! 7
) 
{ 
_userService 
= 
userService "
;" ##
_registrationRepository 
=  !"
registrationRepository" 8
;8 9
} 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' ("
StartRegistrationAsync) ?
(? @$
RegistrationStartRequest@ X
requestY `
)` a
{ 
var 
usernameExists 
= 
await "
_userService# /
./ 0
UsernameExistsAsync0 C
(C D
requestD K
.K L
UsernameL T
)T U
;U V
if 

( 
usernameExists 
) 
return 
new 
( 
) 
{ 
Success "
=# $
false% *
,* +
Message, 3
=4 5
$str6 P
}Q R
;R S
var!! 
emailExists!! 
=!! 
await!! 
_userService!!  ,
.!!, -
EmailExistsAsync!!- =
(!!= >
request!!> E
.!!E F
Email!!F K
)!!K L
;!!L M
if"" 

("" 
emailExists"" 
)"" 
return## 
new## 
(## 
)## 
{## 
Success## "
=### $
false##% *
,##* +
Message##, 3
=##4 5
$str##6 M
}##N O
;##O P
var%% 
registration%% 
=%% 
new%% 
RegistrationBasic%% 0
{&& 	
Email'' 
='' 
request'' 
.'' 
Email'' !
,''! "
Username(( 
=(( 
request(( 
.(( 
Username(( '
,((' (
Password)) 
=)) 
request)) 
.)) 
Password)) '
.))' (
Hash))( ,
()), -
)))- .
,)). /
AuthCode** 
=** 
RandomString** #
.**# $ 
GenerateRandomString**$ 8
(**8 9
)**9 :
}++ 	
;++	 

var-- 
id-- 
=-- 
await-- #
_registrationRepository-- .
.--. /
InsertAsync--/ :
(--: ;
registration--; G
)--G H
;--H I
return// 
new// 
(// 
)// 
{// 
Success// 
=//  
true//! %
,//% &
Data//' +
=//, -
id//. 0
}//1 2
;//2 3
}00 
public22 

async22 
Task22 
<22 
ServerResult22 "
<22" #
int22# &
>22& '
>22' (!
AuthRegistrationAsync22) >
(22> ?#
RegistrationAuthRequest22? V
request22W ^
)22^ _
{33 
var44 
registration44 
=44 
await44  #
_registrationRepository44! 8
.448 9
GetByID449 @
(44@ A
request44A H
.44H I
RegistrationID44I W
)44W X
;44X Y
if55 

(55 
registration55 
is55 
null55  
)55  !
return66 
new66 
(66 
)66 
{66 
Success66 "
=66# $
false66% *
,66* +
Message66, 3
=664 5
$str666 T
}66U V
;66V W
if88 

(88 
!88 
registration88 
.88 
AuthCode88 "
.88" #
Equals88# )
(88) *
request88* 1
.881 2
AuthCode882 :
)88: ;
)88; <
return99 
new99 
(99 
)99 
{99 
Success99 "
=99# $
false99% *
,99* +
Message99, 3
=994 5
$str996 Y
}99Z [
;99[ \
int;; 
userId;; 
=;; 
await;; 
_userService;; '
.;;' (
CreateUserAsync;;( 7
(;;7 8
registration;;8 D
);;D E
;;;E F
await== #
_registrationRepository== %
.==% &!
AddUserToRegistration==& ;
(==; <
registration==< H
.==H I
ID==I K
,==K L
userId==M S
)==S T
;==T U
return?? 
new?? 
(?? 
)?? 
{?? 
Success?? 
=??  
true??! %
,??% &
Data??' +
=??, -
userId??. 4
}??5 6
;??6 7
}@@ 
}AA Ë
SC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Registration\IRegistrationService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Registration *
;* +
public 
	interface  
IRegistrationService %
{ 
Task		 
<		 	
ServerResult			 
<		 
int		 
>		 
>		 "
StartRegistrationAsync		 2
(		2 3$
RegistrationStartRequest		3 K
request		L S
)		S T
;		T U
Task

 
<

 	
ServerResult

	 
<

 
int

 
>

 
>

 !
AuthRegistrationAsync

 1
(

1 2#
RegistrationAuthRequest

2 I
request

J Q
)

Q R
;

R S
} ∏4
SC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Notifications\NotificationService.cs
	namespace

 	
KTPS


 
.

 
Model

 
.

 
Services

 
.

 
Notifications

 +
;

+ ,
public 
class 
NotificationService  
:! " 
INotificationService# 7
{ 
private 
readonly #
INotificationRepository ,#
_notificationRepository- D
;D E
private 
readonly 
IFriendsService $
_friendsService% 4
;4 5
private 
readonly 
IGroupsService #
_groupsService$ 2
;2 3
public 

NotificationService 
( #
INotificationRepository "
notificationRepository  6
,6 7
IFriendsService 
friendsService &
,& '
IGroupsService 
groupsService $
) 	
{ #
_notificationRepository 
=  !"
notificationRepository" 8
;8 9
_friendsService 
= 
friendsService (
;( )
_groupsService 
= 
groupsService &
;& '
} 
public 

async 
Task 
< 
ServerResult "
<" #
int# &
>& '
>' (
CreateAsync) 4
(4 5%
CreateNotificationRequest5 N
requestO V
)V W
{ 
try 
{   	
var!! 
newNotification!! 
=!!  !
new!!" %
Notification!!& 2
(!!2 3
)!!3 4
{!!5 6
SenderID!!7 ?
=!!@ A
request!!B I
.!!I J
SenderID!!J R
,!!R S

ReceiverID!!T ^
=!!_ `
request!!a h
.!!h i

ReceiverID!!i s
,!!s t
Type!!u y
=!!z {
request	!!| É
.
!!É Ñ
Type
!!Ñ à
,
!!à â
GroupID
!!ä ë
=
!!í ì
request
!!î õ
.
!!õ ú
GroupId
!!ú £
}
!!§ •
;
!!• ¶
var"" 
id"" 
="" 
await"" #
_notificationRepository"" 2
.""2 3
InsertAsync""3 >
(""> ?
newNotification""? N
)""N O
;""O P
return## 
new## 
(## 
)## 
{## 
Success## "
=### $
true##% )
,##) *
Data##+ /
=##0 1
id##2 4
}##5 6
;##6 7
}$$ 	
catch%% 
{&& 	
return'' 
new'' 
('' 
)'' 
{'' 
Success'' "
=''# $
false''% *
,''* +
Message'', 3
=''4 5
$str''6 H
}''I J
;''J K
}(( 	
})) 
public++ 

async++ 
Task++ 
<++ 
ServerResult++ "
<++" #
IEnumerable++# .
<++. /
Notification++/ ;
>++; <
>++< =
>++= >
	ListAsync++? H
(++H I
int++I L
userId++M S
)++S T
{,, 
try-- 
{.. 	
var// 
notifications// 
=// 
await//  %#
_notificationRepository//& =
.//= >
	ListAsync//> G
(//G H
userId//H N
)//N O
;//O P
return00 
new00 
(00 
)00 
{00 
Success00 "
=00# $
true00% )
,00) *
Data00+ /
=000 1
notifications002 ?
}00@ A
;00A B
}11 	
catch22 
{33 	
return44 
new44 
(44 
)44 
{44 
Success44 "
=44# $
false44% *
,44* +
Message44, 3
=444 5
$str446 H
}44I J
;44J K
}55 	
}66 
public88 

async88 
Task88 
<88 
ServerResult88 "
>88" #
RespondAsync88$ 0
(880 1&
RespondNotificationRequest881 K
request88L S
)88S T
{99 
try:: 
{;; 	
await<< #
_notificationRepository<< )
.<<) *
RespondAsync<<* 6
(<<6 7
request<<7 >
)<<> ?
;<<? @
var== 
notification== 
=== 
await== $#
_notificationRepository==% <
.==< =
GetAsync=== E
(==E F
request==F M
.==M N
NotificationID==N \
)==\ ]
;==] ^
if?? 
(?? 
!?? 
request?? 
.?? 
Accept?? 
)?? 
return@@ 
new@@ 
(@@ 
)@@ 
{@@ 
Success@@ &
=@@' (
true@@) -
}@@. /
;@@/ 0
switchBB 
(BB 
notificationBB  
.BB  !
TypeBB! %
)BB% &
{CC 
caseDD 
$strDD 
:DD 
{EE 
awaitFF 
_friendsServiceFF -
.FF- .
AddFriendAsyncFF. <
(FF< =
notificationFF= I
.FFI J
SenderIDFFJ R
,FFR S
notificationFFT `
.FF` a

ReceiverIDFFa k
)FFk l
;FFl m
breakGG 
;GG 
}HH 
caseII 
$strII 
:II 
{JJ 
awaitKK 
_groupsServiceKK ,
.KK, -
AddGroupMemberAsyncKK- @
(KK@ A
(KKA B
intKKB E
)KKE F
notificationKKF R
.KKR S
GroupIDKKS Z
,KKZ [
notificationKK\ h
.KKh i

ReceiverIDKKi s
)KKs t
;KKt u
breakLL 
;LL 
}MM 
defaultNN 
:NN 
breakNN 
;NN 
}OO 
returnQQ 
newQQ 
(QQ 
)QQ 
{QQ 
SuccessQQ "
=QQ# $
trueQQ% )
}QQ* +
;QQ+ ,
}RR 	
catchSS 
{TT 	
returnUU 
newUU 
(UU 
)UU 
{UU 
SuccessUU "
=UU# $
falseUU% *
,UU* +
MessageUU, 3
=UU4 5
$strUU6 H
}UUI J
;UUJ K
}VV 	
}WW 
}YY â	
TC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Notifications\INotificationService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Notifications +
;+ ,
public		 
	interface		  
INotificationService		 %
{

 
public 

Task 
< 
ServerResult 
< 
int  
>  !
>! "
CreateAsync# .
(. /%
CreateNotificationRequest/ H
requestI P
)P Q
;Q R
public 

Task 
< 
ServerResult 
< 
IEnumerable (
<( )
Notification) 5
>5 6
>6 7
>7 8
	ListAsync9 B
(B C
intC F
userIdG M
)M N
;N O
public 

Task 
< 
ServerResult 
> 
RespondAsync *
(* +&
RespondNotificationRequest+ E
requestF M
)M N
;N O
} ûF
DC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Login\LoginService.cs
	namespace		 	
KTPS		
 
.		 
Model		 
.		 
Services		 
.		 
Login		 #
;		# $
public 
class 
LoginService 
: 
ILoginService )
{ 
private 
readonly 
IUserService !
_userService" .
;. /
private 
readonly $
IPasswordResetRepository -$
_passwordResetRepository. F
;F G
public 

LoginService 
( 
IUserService 
userService  
,  !$
IPasswordResetRepository  #
passwordResetRepository! 8
) 	
{ 
_userService 
= 
userService "
;" #$
_passwordResetRepository  
=! "#
passwordResetRepository# :
;: ;
} 
public 

async 
Task 
< 
ServerResult "
>" #
ResetPasswordAsync$ 6
(6 7 
ResetPasswordRequest7 K
requestL S
)S T
{ 
try 
{ 	
var 
user 
= 
await 
_userService )
.) *
GetUserByIdAsync* :
(: ;
request; B
.B C
UserIDC I
)I J
;J K
if 
( 
user 
== 
null 
) 
return 
new 
( 
) 
{ 
Success &
=' (
false) .
,. /
Message0 7
=8 9
$str: K
}L M
;M N
var!! 
code!! 
=!! 
await!! $
_passwordResetRepository!! 5
.!!5 6
GetCodeAsync!!6 B
(!!B C
request!!C J
.!!J K
UserID!!K Q
)!!Q R
;!!R S
if"" 
("" 
!"" 
code"" 
."" 
Equals"" 
("" 
request"" $
.""$ %
	AuthCheck""% .
)"". /
)""/ 0
return## 
new## 
(## 
)## 
{## 
Success## &
=##' (
false##) .
,##. /
Message##0 7
=##8 9
$str##: L
}##M N
;##N O
var%% 
newPasswordHashed%% !
=%%" #
request%%$ +
.%%+ ,
NewPassword%%, 7
.%%7 8
Hash%%8 <
(%%< =
)%%= >
;%%> ?
user&& 
.&& 
Password&& 
=&& 
newPasswordHashed&& -
;&&- .
await(( 
_userService(( 
.(( 
UpdateUserAsync(( .
(((. /
user((/ 3
)((3 4
;((4 5
return)) 
new)) 
()) 
))) 
{)) 
Success)) "
=))# $
true))% )
}))* +
;))+ ,
}** 	
catch++ 
{,, 	
return-- 
new-- 
(-- 
)-- 
{-- 
Success-- "
=--# $
false--% *
,--* +
Message--, 3
=--4 5
$str--6 H
}--I J
;--J K
}.. 	
}// 
public11 

async11 
Task11 
<11 
ServerResult11 "
>11" #"
ResetPasswordAuthAsync11$ :
(11: ;$
ResetPasswordAuthRequest11; S
request11T [
)11[ \
{22 
try33 
{44 	
var55 
code55 
=55 
await55 $
_passwordResetRepository55 5
.555 6
GetCodeAsync556 B
(55B C
request55C J
.55J K
UserID55K Q
)55Q R
;55R S
if66 
(66 
!66 
code66 
.66 
Equals66 
(66 
request66 $
.66$ %
RecoveryCode66% 1
)661 2
)662 3
return77 
new77 
(77 
)77 
{77 
Success77 &
=77' (
false77) .
,77. /
Message770 7
=778 9
$str77: T
}77U V
;77V W
return99 
new99 
(99 
)99 
{99 
Success99 "
=99# $
true99% )
}99* +
;99+ ,
}:: 	
catch;; 
{<< 	
return== 
new== 
(== 
)== 
{== 
Success== "
===# $
false==% *
,==* +
Message==, 3
===4 5
$str==6 H
}==I J
;==J K
}>> 	
}?? 
publicAA 

asyncAA 
TaskAA 
<AA 
ServerResultAA "
<AA" #
intAA# &
>AA& '
>AA' (
ForgotPasswordAsyncAA) <
(AA< =!
ForgotPasswordRequestAA= R
requestAAS Z
)AAZ [
{BB 
tryCC 
{DD 	
varEE 
userEE 
=EE 
awaitEE 
_userServiceEE )
.EE) *
GetUserByEmailAsyncEE* =
(EE= >
requestEE> E
.EEE F
EmailEEF K
)EEK L
;EEL M
ifFF 
(FF 
userFF 
==FF 
nullFF 
)FF 
returnGG 
newGG 
(GG 
)GG 
{GG 
SuccessGG &
=GG' (
falseGG) .
,GG. /
MessageGG0 7
=GG8 9
$strGG: `
}GGa b
;GGb c
varII 
recoveryCodeII 
=II 
RandomStringII +
.II+ , 
GenerateRandomStringII, @
(II@ A
)IIA B
;IIB C
awaitJJ $
_passwordResetRepositoryJJ *
.JJ* +
InsertCodeAsyncJJ+ :
(JJ: ;
userJJ; ?
.JJ? @
IDJJ@ B
,JJB C
recoveryCodeJJD P
)JJP Q
;JJQ R
returnLL 
newLL 
(LL 
)LL 
{LL 
SuccessLL "
=LL# $
trueLL% )
,LL) *
DataLL+ /
=LL0 1
userLL2 6
.LL6 7
IDLL7 9
}LL: ;
;LL; <
}MM 	
catchNN 
{OO 	
returnPP 
newPP 
(PP 
)PP 
{PP 
SuccessPP "
=PP# $
falsePP% *
,PP* +
MessagePP, 3
=PP4 5
$strPP6 H
}PPI J
;PPJ K
}QQ 	
}RR 
publicTT 

asyncTT 
TaskTT 
<TT 
ServerResultTT "
<TT" #
intTT# &
>TT& '
>TT' (

LoginAsyncTT) 3
(TT3 4
LoginRequestTT4 @
requestTTA H
)TTH I
{UU 
tryVV 
{WW 	
varXX 
userXX 
=XX 
awaitXX 
_userServiceXX )
.XX) *"
GetUserByUsernameAsyncXX* @
(XX@ A
requestXXA H
.XXH I
UsernameXXI Q
)XXQ R
;XXR S
ifYY 
(YY 
userYY 
isYY 
nullYY 
)YY 
returnZZ 
newZZ 
(ZZ 
)ZZ 
{ZZ 
SuccessZZ &
=ZZ' (
falseZZ) .
,ZZ. /
MessageZZ0 7
=ZZ8 9
$strZZ: P
}ZZQ R
;ZZR S
var\\ 
hashedPassword\\ 
=\\  
request\\! (
.\\( )
Password\\) 1
.\\1 2
Hash\\2 6
(\\6 7
)\\7 8
;\\8 9
if]] 
(]] 
!]] 
user]] 
.]] 
Password]] 
.]] 
Equals]] %
(]]% &
hashedPassword]]& 4
)]]4 5
)]]5 6
return^^ 
new^^ 
(^^ 
)^^ 
{^^ 
Success^^ &
=^^' (
false^^) .
,^^. /
Message^^0 7
=^^8 9
$str^^: K
}^^L M
;^^M N
return`` 
new`` 
(`` 
)`` 
{`` 
Success`` "
=``# $
true``% )
,``) *
Data``+ /
=``0 1
user``2 6
.``6 7
ID``7 9
}``: ;
;``; <
}aa 	
catchbb 
{cc 	
returndd 
newdd 
(dd 
)dd 
{dd 
Successdd "
=dd# $
falsedd% *
,dd* +
Messagedd, 3
=dd4 5
$strdd6 H
}ddI J
;ddJ K
}ee 	
}ff 
}gg ‘	
EC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Login\ILoginService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Login #
;# $
public 
	interface 
ILoginService 
{ 
Task		 
<		 	
ServerResult			 
<		 
int		 
>		 
>		 

LoginAsync		 &
(		& '
LoginRequest		' 3
request		4 ;
)		; <
;		< =
Task

 
<

 	
ServerResult

	 
<

 
int

 
>

 
>

 
ForgotPasswordAsync

 /
(

/ 0!
ForgotPasswordRequest

0 E
request

F M
)

M N
;

N O
Task 
< 	
ServerResult	 
> "
ResetPasswordAuthAsync -
(- .$
ResetPasswordAuthRequest. F
requestG N
)N O
;O P
Task 
< 	
ServerResult	 
> 
ResetPasswordAsync )
() * 
ResetPasswordRequest* >
request? F
)F G
;G H
} ÿq
DC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Items\ItemsService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Items #
;# $
public 
class 
ItemsService 
: 
IItemsService )
{ 
private 
readonly 
IGroupsService #
_groupsService$ 2
;2 3
private 
readonly 
IItemMembersService (
_itemMembersService) <
;< =
private 
readonly 
IItemsRepository %
_itemsRepository& 6
;6 7
public 

ItemsService 
( 
IGroupsService 
groupsService $
,$ %
IItemMembersService 
itemMembersService .
,. /
IItemsRepository 
itemsRepository (
) 	
{ 
_groupsService 
= 
groupsService &
;& '
_itemMembersService 
= 
itemMembersService 0
;0 1
_itemsRepository 
= 
itemsRepository *
;* +
} 
public 

async 
Task 
< 
ServerResult "
>" #
CreateItemAsync$ 3
(3 4
CreateItemRequest4 E
requestF M
)M N
{ 
try   
{!! 	
var"" 
group"" 
="" 
await"" 
_groupsService"" ,
."", -
GetGroupBasicAsync""- ?
(""? @
request""@ G
.""G H
GroupId""H O
)""O P
;""P Q
if## 
(## 
group## 
is## 
null## 
)## 
return$$ 
new$$ 
($$ 
)$$ 
{$$ 
Success$$ &
=$$' (
false$$) .
,$$. /
Message$$0 7
=$$8 9
$str$$: Q
}$$R S
;$$S T
var&& 
id&& 
=&& 
await&& 
_itemsRepository&& +
.&&+ ,
InsertAsync&&, 7
(&&7 8
new&&8 ;
(&&; <
)&&< =
{'' 
GroupId(( 
=(( 
request(( !
.((! "
GroupId((" )
,(() *
Name)) 
=)) 
request)) 
.)) 
Name)) #
,))# $
Quantity** 
=** 
request** "
.**" #
Quantity**# +
,**+ ,
Price++ 
=++ 
request++ 
.++  
Price++  %
},, 
),, 
;,, 
foreach.. 
(.. 
var.. 
guestId..  
in..! #
request..$ +
...+ ,
GuestIds.., 4
)..4 5
await// 
_itemMembersService// )
.//) *
AddItemMemberAsync//* <
(//< =
new//= @
(//@ A
)//A B
{//C D
ItemId//E K
=//L M
id//N P
,//P Q
GuestId//R Y
=//Z [
guestId//\ c
}//d e
)//e f
;//f g
foreach11 
(11 
var11 
userId11 
in11  "
request11# *
.11* +
UserIds11+ 2
)112 3
await22 
_itemMembersService22 )
.22) *
AddItemMemberAsync22* <
(22< =
new22= @
(22@ A
)22A B
{22C D
ItemId22E K
=22L M
id22N P
,22P Q
UserId22R X
=22Y Z
userId22[ a
}22b c
)22c d
;22d e
return44 
new44 
(44 
)44 
{44 
Success44 "
=44# $
true44% )
}44* +
;44+ ,
}55 	
catch66 
(66 
	Exception66 
)66 
{77 	
return88 
new88 
(88 
)88 
{88 
Success88 "
=88# $
false88% *
,88* +
Message88, 3
=884 5
$str886 H
}88I J
;88J K
}99 	
}:: 
public<< 

async<< 
Task<< 
<<< 
ServerResult<< "
><<" #
EditItemAsync<<$ 1
(<<1 2
EditItemRequest<<2 A
request<<B I
)<<I J
{== 
try?? 
{@@ 	
varAA 
itemAA 
=AA 
awaitAA 
_itemsRepositoryAA -
.AA- .
GetAsyncAA. 6
(AA6 7
requestAA7 >
.AA> ?
ItemIdAA? E
)AAE F
;AAF G
ifBB 
(BB 
itemBB 
isBB 
nullBB 
)BB 
returnCC 
newCC 
(CC 
)CC 
{CC 
SuccessCC &
=CC' (
falseCC) .
,CC. /
MessageCC0 7
=CC8 9
$strCC: P
}CCQ R
;CCR S
itemEE 
.EE 
NameEE 
=EE 
requestEE 
.EE  
NameEE  $
;EE$ %
itemFF 
.FF 
PriceFF 
=FF 
requestFF  
.FF  !
PriceFF! &
;FF& '
itemGG 
.GG 
QuantityGG 
=GG 
requestGG #
.GG# $
QuantityGG$ ,
;GG, -
awaitHH 
_itemsRepositoryHH "
.HH" #
UpdateAsyncHH# .
(HH. /
itemHH/ 3
)HH3 4
;HH4 5
varJJ 
membersJJ 
=JJ 
awaitJJ 
_itemMembersServiceJJ  3
.JJ3 4
GetMembersAsyncJJ4 C
(JJC D
requestJJD K
.JJK L
ItemIdJJL R
)JJR S
;JJS T
varKK 
guestsKK 
=KK 
membersKK  
.KK  !
WhereKK! &
(KK& '
xKK' (
=>KK) +
xKK, -
.KK- .
GuestIdKK. 5
isKK6 8
notKK9 <
nullKK= A
)KKA B
.KKB C
SelectKKC I
(KKI J
xKKJ K
=>KKL N
xKKO P
.KKP Q
GuestIdKKQ X
.KKX Y
ValueKKY ^
)KK^ _
.KK_ `
ToListKK` f
(KKf g
)KKg h
;KKh i
varLL 
usersLL 
=LL 
membersLL 
.LL  
WhereLL  %
(LL% &
xLL& '
=>LL( *
xLL+ ,
.LL, -
UserIdLL- 3
isLL4 6
notLL7 :
nullLL; ?
)LL? @
.LL@ A
SelectLLA G
(LLG H
xLLH I
=>LLJ L
xLLM N
.LLN O
UserIdLLO U
.LLU V
ValueLLV [
)LL[ \
.LL\ ]
ToListLL] c
(LLc d
)LLd e
;LLe f
varNN 
guestsToAddNN 
=NN 
requestNN %
.NN% &
GuestIdsNN& .
.NN. /
WhereNN/ 4
(NN4 5
xNN5 6
=>NN7 9
!NN: ;
guestsNN; A
.NNA B
ContainsNNB J
(NNJ K
xNNK L
)NNL M
)NNM N
;NNN O
varOO 

usersToAddOO 
=OO 
requestOO $
.OO$ %
UserIdsOO% ,
.OO, -
WhereOO- 2
(OO2 3
xOO3 4
=>OO5 7
!OO8 9
usersOO9 >
.OO> ?
ContainsOO? G
(OOG H
xOOH I
)OOI J
)OOJ K
;OOK L
foreachQQ 
(QQ 
varQQ 
guestQQ 
inQQ !
guestsToAddQQ" -
)QQ- .
awaitRR 
_itemMembersServiceRR )
.RR) *
AddItemMemberAsyncRR* <
(RR< =
newRR= @
(RR@ A
)RRA B
{RRC D
ItemIdRRE K
=RRL M
requestRRN U
.RRU V
ItemIdRRV \
,RR\ ]
GuestIdRR^ e
=RRf g
guestRRh m
}RRn o
)RRo p
;RRp q
foreachTT 
(TT 
varTT 
userTT 
inTT  

usersToAddTT! +
)TT+ ,
awaitUU 
_itemMembersServiceUU )
.UU) *
AddItemMemberAsyncUU* <
(UU< =
newUU= @
(UU@ A
)UUA B
{UUC D
ItemIdUUE K
=UUL M
requestUUN U
.UUU V
ItemIdUUV \
,UU\ ]
UserIdUU^ d
=UUe f
userUUg k
}UUl m
)UUm n
;UUn o
varWW 
guestsToRemoveWW 
=WW  
guestsWW! '
.WW' (
WhereWW( -
(WW- .
xWW. /
=>WW0 2
!WW3 4
requestWW4 ;
.WW; <
GuestIdsWW< D
.WWD E
ContainsWWE M
(WWM N
xWWN O
)WWO P
)WWP Q
;WWQ R
varXX 
usersToRemoveXX 
=XX 
usersXX  %
.XX% &
WhereXX& +
(XX+ ,
xXX, -
=>XX. 0
!XX1 2
requestXX2 9
.XX9 :
UserIdsXX: A
.XXA B
ContainsXXB J
(XXJ K
xXXK L
)XXL M
)XXM N
;XXN O
foreachZZ 
(ZZ 
varZZ 
guestZZ 
inZZ !
guestsToRemoveZZ" 0
)ZZ0 1
await[[ 
_itemMembersService[[ )
.[[) *
RemoveGuestAsync[[* :
([[: ;
guest[[; @
)[[@ A
;[[A B
foreach]] 
(]] 
var]] 
user]] 
in]]  
usersToRemove]]! .
)]]. /
await^^ 
_itemMembersService^^ )
.^^) *
RemoveUserAsync^^* 9
(^^9 :
user^^: >
)^^> ?
;^^? @
return`` 
new`` 
(`` 
)`` 
{`` 
Success`` "
=``# $
true``% )
}``* +
;``+ ,
}aa 	
catchbb 
(bb 
	Exceptionbb 
)bb 
{cc 	
returndd 
newdd 
(dd 
)dd 
{dd 
Successdd "
=dd# $
falsedd% *
,dd* +
Messagedd, 3
=dd4 5
$strdd6 H
}ddI J
;ddJ K
}ee 	
}ff 
publichh 

asynchh 
Taskhh 
<hh 
IEnumerablehh !
<hh! "
	ItemBasichh" +
>hh+ ,
>hh, -
GetGroupItemsAsynchh. @
(hh@ A
inthhA D
groupIdhhE L
)hhL M
=>hhN P
awaithhQ V
_itemsRepositoryhhW g
.hhg h
GetByGroupAsynchhh w
(hhw x
groupIdhhx 
)	hh Ä
;
hhÄ Å
publicjj 

asyncjj 
Taskjj 
<jj 
ServerResultjj "
<jj" #
IEnumerablejj# .
<jj. /
	ItemBasicjj/ 8
>jj8 9
>jj9 :
>jj: ;!
GetGroupItemListAsyncjj< Q
(jjQ R
intjjR U
groupIdjjV ]
)jj] ^
{kk 
tryll 
{mm 	
varnn 
groupnn 
=nn 
awaitnn 
_groupsServicenn ,
.nn, -
GetGroupBasicAsyncnn- ?
(nn? @
groupIdnn@ G
)nnG H
;nnH I
ifoo 
(oo 
groupoo 
isoo 
nulloo 
)oo 
returnpp 
newpp 
(pp 
)pp 
{pp 
Successpp &
=pp' (
falsepp) .
,pp. /
Messagepp0 7
=pp8 9
$strpp: Q
}ppR S
;ppS T
varrr 
itemsrr 
=rr 
awaitrr 
_itemsRepositoryrr .
.rr. /
GetByGroupAsyncrr/ >
(rr> ?
groupIdrr? F
)rrF G
;rrG H
returnss 
newss 
(ss 
)ss 
{ss 
Successss "
=ss# $
truess% )
,ss) *
Datass+ /
=ss0 1
itemsss2 7
}ss8 9
;ss9 :
}tt 	
catchuu 
(uu 
	Exceptionuu 
)uu 
{vv 	
returnww 
newww 
(ww 
)ww 
{ww 
Successww "
=ww# $
falseww% *
,ww* +
Messageww, 3
=ww4 5
$strww6 H
}wwI J
;wwJ K
}xx 	
}yy 
public{{ 

async{{ 
Task{{ 
<{{ 
ServerResult{{ "
>{{" #
DeleteItemAsync{{$ 3
({{3 4
int{{4 7
itemId{{8 >
){{> ?
{|| 
try~~ 
{ 	
var
ÄÄ 
item
ÄÄ 
=
ÄÄ 
await
ÄÄ 
_itemsRepository
ÄÄ -
.
ÄÄ- .
GetAsync
ÄÄ. 6
(
ÄÄ6 7
itemId
ÄÄ7 =
)
ÄÄ= >
;
ÄÄ> ?
if
ÅÅ 
(
ÅÅ 
item
ÅÅ 
is
ÅÅ 
null
ÅÅ 
)
ÅÅ 
return
ÇÇ 
new
ÇÇ 
(
ÇÇ 
)
ÇÇ 
{
ÇÇ 
Success
ÇÇ &
=
ÇÇ' (
false
ÇÇ) .
,
ÇÇ. /
Message
ÇÇ0 7
=
ÇÇ8 9
$str
ÇÇ: P
}
ÇÇQ R
;
ÇÇR S
await
ÑÑ 
_itemsRepository
ÑÑ "
.
ÑÑ" #
DeleteAsync
ÑÑ# .
(
ÑÑ. /
itemId
ÑÑ/ 5
)
ÑÑ5 6
;
ÑÑ6 7
await
ÖÖ !
_itemMembersService
ÖÖ %
.
ÖÖ% &!
DeleteByItemIdAsync
ÖÖ& 9
(
ÖÖ9 :
itemId
ÖÖ: @
)
ÖÖ@ A
;
ÖÖA B
return
áá 
new
áá 
(
áá 
)
áá 
{
áá 
Success
áá "
=
áá# $
true
áá% )
}
áá* +
;
áá+ ,
}
àà 	
catch
ââ 
(
ââ 
	Exception
ââ 
)
ââ 
{
ää 	
return
ãã 
new
ãã 
(
ãã 
)
ãã 
{
ãã 
Success
ãã "
=
ãã# $
false
ãã% *
,
ãã* +
Message
ãã, 3
=
ãã4 5
$str
ãã6 H
}
ããI J
;
ããJ K
}
åå 	
}
çç 
}éé ö
JC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Items\ItemMembersService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Items #
;# $
public 
class 
ItemMembersService 
:  !
IItemMembersService" 5
{		 
private

 
readonly

	 !
IItemMemberRepository

 '!
_itemMemberRepository

( =
;

= >
public 
ItemMembersService 
( !
IItemMemberRepository  
itemMemberRepository ,
) 
{ !
_itemMemberRepository 
=  
itemMemberRepository .
;. /
} 
public 
async 
Task 
< 
IEnumerable 
< 
ItemMemberBasic .
>. /
>/ 0
GetMembersAsync1 @
(@ A
intA D
itemIdE K
)K L
=>M O
awaitP U!
_itemMemberRepositoryV k
.k l
GetListAsyncl x
(x y
itemIdy 
)	 Ä
;
Ä Å
public 
async 
Task 
RemoveGuestAsync #
(# $
int$ '
guestId( /
)/ 0
=>1 3
await4 9!
_itemMemberRepository: O
.O P
DeleteGuestAsyncP `
(` a
guestIda h
)h i
;i j
public 
async 
Task 
RemoveUserAsync "
(" #
int# &
userId' -
)- .
=>/ 1
await2 7!
_itemMemberRepository8 M
.M N
DeleteUserAsyncN ]
(] ^
userId^ d
)d e
;e f
public 
async 
Task 
AddItemMemberAsync %
(% &
ItemMemberBasic& 5

itemMember6 @
)@ A
=>B D
awaitE J!
_itemMemberRepositoryK `
.` a
InsertAsynca l
(l m

itemMemberm w
)w x
;x y
public 
async 
Task 
DeleteByItemIdAsync &
(& '
int' *
itemId+ 1
)1 2
=>3 5
await6 ;!
_itemMemberRepository< Q
.Q R
DeleteByItemIdR `
(` a
itemIda g
)g h
;h i
} ¶
EC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Items\IItemsService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Items #
;# $
public		 
	interface		 
IItemsService		 
{

 
Task 
< 	
ServerResult	 
> 
CreateItemAsync &
(& '
CreateItemRequest' 8
request9 @
)@ A
;A B
Task 
< 	
ServerResult	 
> 
EditItemAsync $
($ %
EditItemRequest% 4
request5 <
)< =
;= >
Task 
< 	
IEnumerable	 
< 
	ItemBasic 
> 
>  
GetGroupItemsAsync! 3
(3 4
int4 7
groupId8 ?
)? @
;@ A
Task 
< 	
ServerResult	 
< 
IEnumerable !
<! "
	ItemBasic" +
>+ ,
>, -
>- .!
GetGroupItemListAsync/ D
(D E
intE H
groupIdI P
)P Q
;Q R
Task 
< 	
ServerResult	 
> 
DeleteItemAsync &
(& '
int' *
itemId+ 1
)1 2
;2 3
} ‡
KC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Items\IItemMembersService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Items #
;# $
public 
	interface 
IItemMembersService $
{ 
Task		 
AddItemMemberAsync			 
(		 
ItemMemberBasic		 +

itemMember		, 6
)		6 7
;		7 8
Task

 
<

 	
IEnumerable

	 
<

 
ItemMemberBasic

 $
>

$ %
>

% &
GetMembersAsync

' 6
(

6 7
int

7 :
itemId

; A
)

A B
;

B C
Task 
RemoveGuestAsync	 
( 
int 
guestId %
)% &
;& '
Task 
RemoveUserAsync	 
( 
int 
userId #
)# $
;$ %
Task 
DeleteByItemIdAsync	 
( 
int  
itemId! '
)' (
;( )
} •
GC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Groups\IGroupsService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Groups $
;$ %
public

 
	interface

 
IGroupsService

 
{ 
Task 
< 	
ServerResult	 
< 
int 
> 
> 
NewGroupAsync )
() *
NewGroupRequest* 9
request: A
)A B
;B C
Task 
< 	
ServerResult	 
> 
EditGroupAsync %
(% &
EditGroupRequest& 6
request7 >
)> ?
;? @
Task 
< 	
ServerResult	 
> 
DeleteGroupAsync '
(' (
DeleteGroupRequest( :
request; B
)B C
;C D
Task 
< 	
ServerResult	 
< 
IEnumerable !
<! "

GroupBasic" ,
>, -
>- .
>. /
GetGroupListAsync0 A
(A B
intB E
userIdF L
)L M
;M N
Task 
< 	
ServerResult	 
> #
RemoveGroupMembersAsync .
(. /%
RemoveGroupMembersRequest/ H
requestI P
)P Q
;Q R
Task 
< 	
ServerResult	 
< #
GetGroupMembersResponse -
>- .
>. /
GetMemberListAsync0 B
(B C
intC F
groupIdG N
)N O
;O P
Task 
< 	
ServerResult	 
< 
int 
> 
> 
AddGuestAsync )
() *
AddGuestRequest* 9
request: A
)A B
;B C
Task 
< 	
ServerResult	 
> 
AddGroupMemberAsync *
(* +
int+ .
groupId/ 6
,6 7
int8 ;
userId< B
)B C
;C D
Task 
< 	
ServerResult	 
> 
LeaveGroupAsync &
(& '
LeaveGroupRequest' 8
request9 @
)@ A
;A B
Task 
< 	
ServerResult	 
< 

GroupBasic  
>  !
>! "
GetGroupInfoAsync# 4
(4 5
int5 8
groupId9 @
)@ A
;A B
Task 
< 	

GroupBasic	 
> 
GetGroupBasicAsync '
(' (
int( +
groupId, 3
)3 4
;4 5
} ∏¶
FC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Groups\GroupsService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Groups $
;$ %
public 
class 
GroupsService 
: 
IGroupsService +
{ 
private 
readonly 
IGroupsRepository &
_groupsRepository' 8
;8 9
private 
readonly #
IGroupMembersRepository ,#
_groupMembersRepository- D
;D E
private 
readonly 
IGuestsRepository &
_guestsRepository' 8
;8 9
public 

GroupsService 
( 
IGroupsRepository 
groupsRepository *
,* +#
IGroupMembersRepository "
groupMembersRepository  6
,6 7
IGuestsRepository 
guestsRepository *
) 	
{ 
_groupsRepository 
= 
groupsRepository ,
;, -#
_groupMembersRepository 
=  !"
groupMembersRepository" 8
;8 9
_guestsRepository 
= 
guestsRepository ,
;, -
} 
public   

async   
Task   
<   
ServerResult   "
<  " #
int  # &
>  & '
>  ' (
NewGroupAsync  ) 6
(  6 7
NewGroupRequest  7 F
request  G N
)  N O
{!! 
try"" 
{## 	
var$$ 
ID$$ 
=$$ 
await$$ 
_groupsRepository$$ ,
.$$, -
InsertAsync$$- 8
($$8 9
new$$9 <
($$< =
)$$= >
{%% 
Name&& 
=&& 
request&& 
.&& 
Name&& #
,&&# $
OwnerUserID'' 
='' 
request'' %
.''% &
UserID''& ,
}(( 
)(( 
;(( 
await** #
_groupMembersRepository** )
.**) *
AddGroupMemberAsync*** =
(**= >
request**> E
.**E F
UserID**F L
,**L M
ID**N P
)**P Q
;**Q R
return,, 
new,, 
(,, 
),, 
{,, 
Success,, "
=,,# $
true,,% )
,,,) *
Data,,+ /
=,,0 1
ID,,2 4
},,5 6
;,,6 7
}-- 	
catch.. 
(.. 
	Exception.. 
).. 
{// 	
return00 
new00 
(00 
)00 
{00 
Success00 "
=00# $
false00% *
,00* +
Message00, 3
=004 5
$str006 H
}00I J
;00J K
}11 	
}22 
public44 

async44 
Task44 
<44 
ServerResult44 "
>44" #
EditGroupAsync44$ 2
(442 3
EditGroupRequest443 C
request44D K
)44K L
{55 
try66 
{77 	
var88 
group88 
=88 
await88 
_groupsRepository88 /
.88/ 0
GetGroupAsync880 =
(88= >
request88> E
.88E F
ID88F H
)88H I
;88I J
if99 
(99 
group99 
is99 
null99 
)99 
return:: 
new:: 
(:: 
):: 
{:: 
Success:: &
=::' (
false::) .
,::. /
Message::0 7
=::8 9
$str::: Q
}::R S
;::S T
if<< 
(<< 
!<< 
group<< 
.<< 
OwnerUserID<< "
.<<" #
Equals<<# )
(<<) *
request<<* 1
.<<1 2
UserID<<2 8
)<<8 9
)<<9 :
return== 
new== 
(== 
)== 
{== 
Success== &
===' (
false==) .
,==. /
Message==0 7
===8 9
$str==: c
}==d e
;==e f
group?? 
.?? 
Name?? 
=?? 
request??  
.??  !
Name??! %
;??% &
await@@ 
_groupsRepository@@ #
.@@# $
UpdateAsync@@$ /
(@@/ 0
group@@0 5
)@@5 6
;@@6 7
returnBB 
newBB 
(BB 
)BB 
{BB 
SuccessBB "
=BB# $
trueBB% )
}BB* +
;BB+ ,
}CC 	
catchDD 
(DD 
	ExceptionDD 
)DD 
{EE 	
returnFF 
newFF 
(FF 
)FF 
{FF 
SuccessFF "
=FF# $
falseFF% *
,FF* +
MessageFF, 3
=FF4 5
$strFF6 H
}FFI J
;FFJ K
}GG 	
}HH 
publicJJ 

asyncJJ 
TaskJJ 
<JJ 
ServerResultJJ "
>JJ" #
DeleteGroupAsyncJJ$ 4
(JJ4 5
DeleteGroupRequestJJ5 G
requestJJH O
)JJO P
{KK 
tryLL 
{MM 	
varNN 
groupNN 
=NN 
awaitNN 
_groupsRepositoryNN /
.NN/ 0
GetGroupAsyncNN0 =
(NN= >
requestNN> E
.NNE F
IDNNF H
)NNH I
;NNI J
ifOO 
(OO 
groupOO 
isOO 
nullOO 
)OO 
returnPP 
newPP 
(PP 
)PP 
{PP 
SuccessPP &
=PP' (
falsePP) .
,PP. /
MessagePP0 7
=PP8 9
$strPP: Q
}PPR S
;PPS T
ifRR 
(RR 
!RR 
groupRR 
.RR 
OwnerUserIDRR "
.RR" #
EqualsRR# )
(RR) *
requestRR* 1
.RR1 2
UserIDRR2 8
)RR8 9
)RR9 :
returnSS 
newSS 
(SS 
)SS 
{SS 
SuccessSS &
=SS' (
falseSS) .
,SS. /
MessageSS0 7
=SS8 9
$strSS: `
}SSa b
;SSb c
awaitUU 
_groupsRepositoryUU #
.UU# $
DeleteAsyncUU$ /
(UU/ 0
requestUU0 7
.UU7 8
IDUU8 :
)UU: ;
;UU; <
varVV 
groupMembersVV 
=VV 
(VV  
awaitVV  %#
_groupMembersRepositoryVV& =
.VV= >
GetByGroupIDAsyncVV> O
(VVO P
groupVVP U
.VVU V
IDVVV X
)VVX Y
)VVY Z
.VVZ [
ToListVV[ a
(VVa b
)VVb c
;VVc d
foreachWW 
(WW 
varWW 
memberWW 
inWW  "
groupMembersWW# /
)WW/ 0
awaitXX #
_groupMembersRepositoryXX -
.XX- ."
DeleteGroupMemberAsyncXX. D
(XXD E
memberXXE K
.XXK L
UserIDXXL R
,XXR S
groupXXT Y
.XXY Z
IDXXZ \
)XX\ ]
;XX] ^
returnYY 
newYY 
(YY 
)YY 
{YY 
SuccessYY "
=YY# $
trueYY% )
}YY* +
;YY+ ,
}ZZ 	
catch[[ 
([[ 
	Exception[[ 
)[[ 
{\\ 	
return]] 
new]] 
(]] 
)]] 
{]] 
Success]] "
=]]# $
false]]% *
,]]* +
Message]], 3
=]]4 5
$str]]6 H
}]]I J
;]]J K
}^^ 	
}__ 
publicaa 

asyncaa 
Taskaa 
<aa 
ServerResultaa "
<aa" #
IEnumerableaa# .
<aa. /

GroupBasicaa/ 9
>aa9 :
>aa: ;
>aa; <
GetGroupListAsyncaa= N
(aaN O
intaaO R
userIDaaS Y
)aaY Z
{bb 
trycc 
{dd 	
varee 
listee 
=ee 
awaitee 
_groupsRepositoryee .
.ee. /
GetUserGroupsAsyncee/ A
(eeA B
userIDeeB H
)eeH I
;eeI J
returnff 
newff 
(ff 
)ff 
{ff 
Successff "
=ff# $
trueff% )
,ff) *
Dataff+ /
=ff0 1
listff2 6
}ff7 8
;ff8 9
}gg 	
catchhh 
(hh 
	Exceptionhh 
)hh 
{ii 	
returnjj 
newjj 
(jj 
)jj 
{jj 
Successjj "
=jj# $
falsejj% *
,jj* +
Messagejj, 3
=jj4 5
$strjj6 H
}jjI J
;jjJ K
}kk 	
}ll 
publicnn 

asyncnn 
Tasknn 
<nn 
ServerResultnn "
>nn" ##
RemoveGroupMembersAsyncnn$ ;
(nn; <%
RemoveGroupMembersRequestnn< U
requestnnV ]
)nn] ^
{oo 
trypp 
{qq 	
varrr 
grouprr 
=rr 
awaitrr 
_groupsRepositoryrr /
.rr/ 0
GetGroupAsyncrr0 =
(rr= >
requestrr> E
.rrE F
GroupIDrrF M
)rrM N
;rrN O
ifss 
(ss 
groupss 
isss 
nullss 
)ss 
returntt 
newtt 
(tt 
)tt 
{tt 
Successtt &
=tt' (
falsett) .
,tt. /
Messagett0 7
=tt8 9
$strtt: Q
}ttR S
;ttS T
ifvv 
(vv 
!vv 
groupvv 
.vv 
OwnerUserIDvv "
.vv" #
Equalsvv# )
(vv) *
requestvv* 1
.vv1 2
RequestUserIDvv2 ?
)vv? @
)vv@ A
returnww 
newww 
(ww 
)ww 
{ww 
Successww &
=ww' (
falseww) .
,ww. /
Messageww0 7
=ww8 9
$strww: d
}wwe f
;wwf g
ifyy 
(yy 
requestyy 
.yy 
UserToRemoveIDyy &
!=yy' )
nullyy* .
&&yy/ 1
requestyy2 9
.yy9 :
UserToRemoveIDyy: H
!=yyI K
groupyyL Q
.yyQ R
OwnerUserIDyyR ]
)yy] ^
awaitzz #
_groupMembersRepositoryzz -
.zz- ."
DeleteGroupMemberAsynczz. D
(zzD E
(zzE F
intzzF I
)zzI J
requestzzJ Q
.zzQ R
UserToRemoveIDzzR `
,zz` a
groupzzb g
.zzg h
IDzzh j
)zzj k
;zzk l
if|| 
(|| 
request|| 
.|| 
GuestToRemoveID|| '
!=||( *
null||+ /
)||/ 0
await}} #
_groupMembersRepository}} -
.}}- .!
DeleteGroupGuestAsync}}. C
(}}C D
(}}D E
int}}E H
)}}H I
request}}I P
.}}P Q
GuestToRemoveID}}Q `
,}}` a
group}}b g
.}}g h
ID}}h j
)}}j k
;}}k l
return 
new 
( 
) 
{ 
Success "
=# $
true% )
}* +
;+ ,
}
ÄÄ 	
catch
ÅÅ 
(
ÅÅ 
	Exception
ÅÅ 
)
ÅÅ 
{
ÇÇ 	
return
ÉÉ 
new
ÉÉ 
(
ÉÉ 
)
ÉÉ 
{
ÉÉ 
Success
ÉÉ "
=
ÉÉ# $
false
ÉÉ% *
,
ÉÉ* +
Message
ÉÉ, 3
=
ÉÉ4 5
$str
ÉÉ6 H
}
ÉÉI J
;
ÉÉJ K
}
ÑÑ 	
}
ÖÖ 
public
áá 

async
áá 
Task
áá 
<
áá 
ServerResult
áá "
<
áá" #%
GetGroupMembersResponse
áá# :
>
áá: ;
>
áá; < 
GetMemberListAsync
áá= O
(
ááO P
int
ááP S
groupID
ááT [
)
áá[ \
{
àà 
try
ââ 
{
ää 	
var
ãã 
group
ãã 
=
ãã 
await
ãã 
_groupsRepository
ãã /
.
ãã/ 0
GetGroupAsync
ãã0 =
(
ãã= >
groupID
ãã> E
)
ããE F
;
ããF G
if
åå 
(
åå 
group
åå 
is
åå 
null
åå 
)
åå 
return
çç 
new
çç 
(
çç 
)
çç 
{
çç 
Success
çç &
=
çç' (
false
çç) .
,
çç. /
Message
çç0 7
=
çç8 9
$str
çç: Q
}
ççR S
;
ççS T
var
èè 
members
èè 
=
èè 
await
èè %
_groupMembersRepository
èè  7
.
èè7 8
GetByGroupIDAsync
èè8 I
(
èèI J
groupID
èèJ Q
)
èèQ R
;
èèR S
var
êê 
filteredMembers
êê 
=
êê  !
members
êê" )
.
êê) *
Where
êê* /
(
êê/ 0
x
êê0 1
=>
êê2 4
x
êê5 6
.
êê6 7
UserID
êê7 =
!=
êê> @
group
êêA F
.
êêF G
OwnerUserID
êêG R
)
êêR S
;
êêS T
var
ëë 
guests
ëë 
=
ëë 
await
ëë 
_guestsRepository
ëë 0
.
ëë0 1
GetByGroupID
ëë1 =
(
ëë= >
groupID
ëë> E
)
ëëE F
;
ëëF G
return
ìì 
new
ìì 
(
ìì 
)
ìì 
{
ìì 
Success
ìì "
=
ìì# $
true
ìì% )
,
ìì) *
Data
ìì+ /
=
ìì0 1
new
ìì2 5
(
ìì5 6
)
ìì6 7
{
ìì8 9
Guests
ìì: @
=
ììA B
guests
ììC I
.
ììI J
ToList
ììJ P
(
ììP Q
)
ììQ R
,
ììR S
Members
ììT [
=
ìì\ ]
filteredMembers
ìì^ m
.
ììm n
ToList
ììn t
(
ììt u
)
ììu v
,
ììv w
OwnerUserIDììx É
=ììÑ Ö
groupììÜ ã
.ììã å
OwnerUserIDììå ó
}ììò ô
}ììö õ
;ììõ ú
}
îî 	
catch
ïï 
(
ïï 
	Exception
ïï 
)
ïï 
{
ññ 	
return
óó 
new
óó 
(
óó 
)
óó 
{
óó 
Success
óó "
=
óó# $
false
óó% *
,
óó* +
Message
óó, 3
=
óó4 5
$str
óó6 H
}
óóI J
;
óóJ K
}
òò 	
}
ôô 
public
õõ 

async
õõ 
Task
õõ 
<
õõ 
ServerResult
õõ "
<
õõ" #
int
õõ# &
>
õõ& '
>
õõ' (
AddGuestAsync
õõ) 6
(
õõ6 7
AddGuestRequest
õõ7 F
request
õõG N
)
õõN O
{
úú 
try
ùù 
{
ûû 	
var
üü 
group
üü 
=
üü 
await
üü 
_groupsRepository
üü /
.
üü/ 0
GetGroupAsync
üü0 =
(
üü= >
request
üü> E
.
üüE F
GroupID
üüF M
)
üüM N
;
üüN O
if
†† 
(
†† 
group
†† 
is
†† 
null
†† 
)
†† 
return
°° 
new
°° 
(
°° 
)
°° 
{
°° 
Success
°° &
=
°°' (
false
°°) .
,
°°. /
Message
°°0 7
=
°°8 9
$str
°°: Q
}
°°R S
;
°°S T
var
££ 
ID
££ 
=
££ 
await
££ 
_guestsRepository
££ ,
.
££, -
InsertAsync
££- 8
(
££8 9
new
££9 <
(
££< =
)
££= >
{
££? @
GroupID
££A H
=
££I J
request
££K R
.
££R S
GroupID
££S Z
,
££Z [
Name
££\ `
=
££a b
request
££c j
.
££j k
Name
££k o
}
££p q
)
££q r
;
££r s
return
§§ 
new
§§ 
(
§§ 
)
§§ 
{
§§ 
Success
§§ "
=
§§# $
true
§§% )
,
§§) *
Data
§§+ /
=
§§0 1
ID
§§2 4
}
§§5 6
;
§§6 7
}
•• 	
catch
¶¶ 
(
¶¶ 
	Exception
¶¶ 
)
¶¶ 
{
ßß 	
return
®® 
new
®® 
(
®® 
)
®® 
{
®® 
Success
®® "
=
®®# $
false
®®% *
,
®®* +
Message
®®, 3
=
®®4 5
$str
®®6 H
}
®®I J
;
®®J K
}
©© 	
}
™™ 
public
¨¨ 

async
¨¨ 
Task
¨¨ 
<
¨¨ 
ServerResult
¨¨ "
>
¨¨" #!
AddGroupMemberAsync
¨¨$ 7
(
¨¨7 8
int
¨¨8 ;
groupID
¨¨< C
,
¨¨C D
int
¨¨E H
userID
¨¨I O
)
¨¨O P
{
≠≠ 
try
ÆÆ 
{
ØØ 	
await
∞∞ %
_groupMembersRepository
∞∞ )
.
∞∞) *!
AddGroupMemberAsync
∞∞* =
(
∞∞= >
userID
∞∞> D
,
∞∞D E
groupID
∞∞F M
)
∞∞M N
;
∞∞N O
return
±± 
new
±± 
(
±± 
)
±± 
{
±± 
Success
±± "
=
±±# $
true
±±% )
}
±±* +
;
±±+ ,
}
≤≤ 	
catch
≥≥ 
(
≥≥ 
	Exception
≥≥ 
)
≥≥ 
{
¥¥ 	
return
µµ 
new
µµ 
(
µµ 
)
µµ 
{
µµ 
Success
µµ "
=
µµ# $
false
µµ% *
,
µµ* +
Message
µµ, 3
=
µµ4 5
$str
µµ6 H
}
µµI J
;
µµJ K
}
∂∂ 	
}
∑∑ 
public
ππ 

async
ππ 
Task
ππ 
<
ππ 
ServerResult
ππ "
>
ππ" #
LeaveGroupAsync
ππ$ 3
(
ππ3 4
LeaveGroupRequest
ππ4 E
request
ππF M
)
ππM N
{
∫∫ 
try
ªª 
{
ºº 	
await
ΩΩ %
_groupMembersRepository
ΩΩ )
.
ΩΩ) *$
DeleteGroupMemberAsync
ΩΩ* @
(
ΩΩ@ A
request
ΩΩA H
.
ΩΩH I
UserID
ΩΩI O
,
ΩΩO P
request
ΩΩQ X
.
ΩΩX Y
GroupID
ΩΩY `
)
ΩΩ` a
;
ΩΩa b
return
ææ 
new
ææ 
(
ææ 
)
ææ 
{
ææ 
Success
ææ "
=
ææ# $
true
ææ% )
}
ææ* +
;
ææ+ ,
}
øø 	
catch
¿¿ 
(
¿¿ 
	Exception
¿¿ 
)
¿¿ 
{
¡¡ 	
return
¬¬ 
new
¬¬ 
(
¬¬ 
)
¬¬ 
{
¬¬ 
Success
¬¬ "
=
¬¬# $
false
¬¬% *
,
¬¬* +
Message
¬¬, 3
=
¬¬4 5
$str
¬¬6 H
}
¬¬I J
;
¬¬J K
}
√√ 	
}
ƒƒ 
public
∆∆ 

async
∆∆ 
Task
∆∆ 
<
∆∆ 
ServerResult
∆∆ "
<
∆∆" #

GroupBasic
∆∆# -
>
∆∆- .
>
∆∆. /
GetGroupInfoAsync
∆∆0 A
(
∆∆A B
int
∆∆B E
groupId
∆∆F M
)
∆∆M N
{
«« 
try
»» 
{
…… 	
var
   
group
   
=
   
await
   
_groupsRepository
   /
.
  / 0
GetGroupAsync
  0 =
(
  = >
groupId
  > E
)
  E F
;
  F G
return
ÀÀ 
new
ÀÀ 
(
ÀÀ 
)
ÀÀ 
{
ÀÀ 
Success
ÀÀ "
=
ÀÀ# $
true
ÀÀ% )
,
ÀÀ) *
Data
ÀÀ+ /
=
ÀÀ0 1
group
ÀÀ2 7
}
ÀÀ8 9
;
ÀÀ9 :
}
ÃÃ 	
catch
ÕÕ 
(
ÕÕ 
	Exception
ÕÕ 
)
ÕÕ 
{
ŒŒ 	
return
œœ 
new
œœ 
(
œœ 
)
œœ 
{
œœ 
Success
œœ "
=
œœ# $
false
œœ% *
,
œœ* +
Message
œœ, 3
=
œœ4 5
$str
œœ6 H
}
œœI J
;
œœJ K
}
–– 	
}
—— 
public
”” 

async
”” 
Task
”” 
<
”” 

GroupBasic
””  
>
””  ! 
GetGroupBasicAsync
””" 4
(
””4 5
int
””5 8
groupId
””9 @
)
””@ A
=>
””B D
await
””E J
_groupsRepository
””K \
.
””\ ]
GetGroupAsync
””] j
(
””j k
groupId
””k r
)
””r s
;
””s t
}‘‘ Æ

IC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Friends\IFriendsService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Friends %
;% &
public		 
	interface		 
IFriendsService		  
{

 
Task 
< 	
ServerResult	 
< 
IEnumerable !
<! "
UserMinimal" -
>- .
>. /
>/ 0
GetFriendListAsync1 C
(C D
intD G
userIdH N
)N O
;O P
Task 
< 	
ServerResult	 
> 
DeleteFriendAsync (
(( )
DeleteFriendRequest) <
request= D
)D E
;E F
Task 
< 	
ServerResult	 
< 
IEnumerable !
<! "
UserMinimal" -
>- .
>. /
>/ 0
FindFriendAsync1 @
(@ A
FindFriendRequestA R
requestS Z
)Z [
;[ \
Task 
AddFriendAsync	 
( 
int 
userId "
," #
int$ '
friendId( 0
)0 1
;1 2
} í/
HC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Friends\FriendsService.cs
	namespace

 	
KTPS


 
.

 
Model

 
.

 
Services

 
.

 
Friends

 %
{ 
public 

class 
FriendsService 
:  !
IFriendsService" 1
{ 
private 
readonly 
IFriendsRepository +
_friendsRepository, >
;> ?
public 
FriendsService 
( 
IFriendsRepository 
friendsRepository 0
) 
{ 	
_friendsRepository 
=  
friendsRepository! 2
;2 3
} 	
public 
async 
Task 
< 
ServerResult &
<& '
IEnumerable' 2
<2 3
UserMinimal3 >
>> ?
>? @
>@ A
GetFriendListAsyncB T
(T U
intU X
userIdY _
)_ `
{ 	
try 
{ 
var 
friends 
= 
await #
_friendsRepository$ 6
.6 7
GetFriendListAsync7 I
(I J
userIdJ P
)P Q
;Q R
return 
new 
( 
) 
{ 
Success &
=' (
true) -
,- .
Data/ 3
=4 5
friends6 =
}> ?
;? @
} 
catch 
( 
	Exception 
) 
{ 
return 
new 
( 
) 
{ 
Success &
=' (
false) .
,. /
Message0 7
=8 9
$str: L
}M N
;N O
}   
}!! 	
public## 
async## 
Task## 
<## 
ServerResult## &
>##& '
DeleteFriendAsync##( 9
(##9 :
DeleteFriendRequest##: M
request##N U
)##U V
{$$ 	
try%% 
{&& 
await'' 
_friendsRepository'' (
.''( )
DeleteFriendAsync'') :
('': ;
request''; B
.''B C
UserID''C I
,''I J
request''K R
.''R S
FriendID''S [
)''[ \
;''\ ]
await(( 
_friendsRepository(( (
.((( )
DeleteFriendAsync(() :
(((: ;
request((; B
.((B C
FriendID((C K
,((K L
request((M T
.((T U
UserID((U [
)(([ \
;((\ ]
return)) 
new)) 
()) 
))) 
{)) 
Success)) &
=))' (
true))) -
})). /
;))/ 0
}** 
catch++ 
(++ 
	Exception++ 
)++ 
{,, 
return-- 
new-- 
(-- 
)-- 
{-- 
Success-- &
=--' (
false--) .
,--. /
Message--0 7
=--8 9
$str--: L
}--M N
;--N O
}.. 
}// 	
public11 
async11 
Task11 
<11 
ServerResult11 &
<11& '
IEnumerable11' 2
<112 3
UserMinimal113 >
>11> ?
>11? @
>11@ A
FindFriendAsync11B Q
(11Q R
FindFriendRequest11R c
request11d k
)11k l
{22 	
try33 
{44 
var55 
availableFriends55 $
=55% &
await55' ,
_friendsRepository55- ?
.55? @
FindFriendAsync55@ O
(55O P
request55P W
.55W X
Input55X ]
)55] ^
;55^ _
var66 
currentFriends66 "
=66# $
await66% *
_friendsRepository66+ =
.66= >
GetFriendListAsync66> P
(66P Q
request66Q X
.66X Y
UserID66Y _
)66_ `
;66` a
var77 
filteredFriends77 #
=77$ %
availableFriends77& 6
.776 7
Where777 <
(77< =
x77= >
=>77? A
x77B C
.77C D
ID77D F
!=77G I
request77J Q
.77Q R
UserID77R X
&&77Y [
!77\ ]
currentFriends77] k
.77k l
Any77l o
(77o p
cf77p r
=>77s u
cf77v x
.77x y
ID77y {
==77| ~
x	77 Ä
.
77Ä Å
ID
77Å É
)
77É Ñ
)
77Ñ Ö
;
77Ö Ü
return99 
new99 
(99 
)99 
{99 
Success99 &
=99' (
true99) -
,99- .
Data99/ 3
=994 5
filteredFriends996 E
}99F G
;99G H
}:: 
catch;; 
(;; 
	Exception;; 
);; 
{<< 
return== 
new== 
(== 
)== 
{== 
Success== &
===' (
false==) .
,==. /
Message==0 7
===8 9
$str==: L
}==M N
;==N O
}>> 
}?? 	
publicAA 
asyncAA 
TaskAA 
AddFriendAsyncAA (
(AA( )
intAA) ,
userIdAA- 3
,AA3 4
intAA5 8
friendIdAA9 A
)AAA B
{BB 	
awaitCC 
_friendsRepositoryCC $
.CC$ %
InsertAsyncCC% 0
(CC0 1
userIdCC1 7
,CC7 8
friendIdCC9 A
)CCA B
;CCB C
awaitDD 
_friendsRepositoryDD $
.DD$ %
InsertAsyncDD% 0
(DD0 1
friendIdDD1 9
,DD9 :
userIdDD; A
)DDA B
;DDB C
}EE 	
}FF 
}GG ·
QC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Calculation\ICalculationService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Calculation )
;) *
public 
	interface 
ICalculationService $
{ 
Task		 
<		 	
ServerResult			 
<		 
CalculationResponse		 )
>		) *
>		* +'
CalculateGroupExpensesAsync		, G
(		G H
int		H K
groupId		L S
)		S T
;		T U
}

 Ø?
PC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Services\Calculation\CalculationService.cs
	namespace 	
KTPS
 
. 
Model 
. 
Services 
. 
Calculation )
;) *
public 
class 
CalculationService 
:  !
ICalculationService" 5
{ 
private 
readonly 
IItemsService "
_itemsService# 0
;0 1
private 
readonly 
IItemMembersService (
_itemMembersService) <
;< =
private 
readonly #
IGroupMembersRepository ,#
_groupMembersRepository- D
;D E
private 
readonly 
IGuestsRepository &
_guestsRepository' 8
;8 9
public 

CalculationService 
( 
IItemsService 
itemsService "
," #
IItemMembersService 
itemMembersService .
,. /#
IGroupMembersRepository "
groupMembersRepository  6
,6 7
IGuestsRepository 
guestsRepository *
) 	
{ 
_itemsService 
= 
itemsService $
;$ %
_itemMembersService 
= 
itemMembersService 0
;0 1#
_groupMembersRepository 
=  !"
groupMembersRepository" 8
;8 9
_guestsRepository 
= 
guestsRepository ,
;, -
} 
public!! 

async!! 
Task!! 
<!! 
ServerResult!! "
<!!" #
CalculationResponse!!# 6
>!!6 7
>!!7 8'
CalculateGroupExpensesAsync!!9 T
(!!T U
int!!U X
groupId!!Y `
)!!` a
{"" 
try## 
{$$ 	
var%% 
items%% 
=%% 
await%% 
_itemsService%% +
.%%+ ,
GetGroupItemsAsync%%, >
(%%> ?
groupId%%? F
)%%F G
;%%G H
if&& 
(&& 
items&& 
?&& 
.&& 
Any&& 
(&& 
)&& 
!=&& 
true&&  $
)&&$ %
return'' 
new'' 
('' 
)'' 
{'' 
Success'' &
=''' (
false'') .
,''. /
Message''0 7
=''8 9
$str'': O
}''P Q
;''Q R
var)) 
guests)) 
=)) 
await)) 
_guestsRepository)) 0
.))0 1
GetByGroupID))1 =
())= >
groupId))> E
)))E F
;))F G
var** 
users** 
=** 
await** #
_groupMembersRepository** 5
.**5 6
GetByGroupIDAsync**6 G
(**G H
groupId**H O
)**O P
;**P Q
var,, 
guestCalculations,, !
=,," #
guests,,$ *
.,,* +
Select,,+ 1
(,,1 2
x,,2 3
=>,,4 6
new,,7 :
GuestCalculation,,; K
{,,L M
GuestId,,N U
=,,V W
x,,X Y
.,,Y Z
ID,,Z \
,,,\ ]
Amount,,^ d
=,,e f
$num,,g i
,,,i j
Name,,k o
=,,p q
x,,r s
.,,s t
Name,,t x
},,y z
),,z {
.,,{ |
ToList	,,| Ç
(
,,Ç É
)
,,É Ñ
;
,,Ñ Ö
var-- 
userCalculations--  
=--! "
users--# (
.--( )
Select--) /
(--/ 0
x--0 1
=>--2 4
new--5 8
UserCalculation--9 H
{--I J
UserId--K Q
=--R S
x--T U
.--U V
ID--V X
,--X Y
Amount--Z `
=--a b
$num--c e
,--e f
Username--g o
=--p q
x--r s
.--s t
Username--t |
}--} ~
)--~ 
.	-- Ä
ToList
--Ä Ü
(
--Ü á
)
--á à
;
--à â
foreach// 
(// 
var// 
item// 
in//  
items//! &
)//& '
{00 
var11 
itemMembers11 
=11  !
await11" '
_itemMembersService11( ;
.11; <
GetMembersAsync11< K
(11K L
item11L P
.11P Q
Id11Q S
)11S T
;11T U
if22 
(22 
itemMembers22 
?22  
.22  !
Any22! $
(22$ %
)22% &
!=22' )
true22* .
)22. /
continue33 
;33 
foreach55 
(55 
var55 
calculation55 (
in55) +
guestCalculations55, =
)55= >
{66 
if77 
(77 
!77 
itemMembers77 $
.77$ %
Any77% (
(77( )
x77) *
=>77+ -
x77. /
.77/ 0
GuestId770 7
==778 :
calculation77; F
.77F G
GuestId77G N
)77N O
)77O P
continue88  
;88  !
var:: 
itemAmountForGuest:: *
=::+ ,
item::- 1
.::1 2
Quantity::2 :
*::; <
item::= A
.::A B
Price::B G
/::H I
itemMembers::J U
.::U V
Count::V [
(::[ \
)::\ ]
;::] ^
calculation;; 
.;;  
Amount;;  &
+=;;' )
itemAmountForGuest;;* <
;;;< =
}<< 
foreach>> 
(>> 
var>> 
calculation>> (
in>>) +
userCalculations>>, <
)>>< =
{?? 
if@@ 
(@@ 
!@@ 
itemMembers@@ $
.@@$ %
Any@@% (
(@@( )
x@@) *
=>@@+ -
x@@. /
.@@/ 0
UserId@@0 6
==@@7 9
calculation@@: E
.@@E F
UserId@@F L
)@@L M
)@@M N
continueAA  
;AA  !
varCC 
itemAmountForUserCC )
=CC* +
itemCC, 0
.CC0 1
QuantityCC1 9
*CC: ;
itemCC< @
.CC@ A
PriceCCA F
/CCG H
itemMembersCCI T
.CCT U
CountCCU Z
(CCZ [
)CC[ \
;CC\ ]
calculationDD 
.DD  
AmountDD  &
+=DD' )
itemAmountForUserDD* ;
;DD; <
}EE 
}FF 
returnHH 
newHH 
(HH 
)HH 
{II 
SuccessJJ 
=JJ 
trueJJ 
,JJ 
DataKK 
=KK 
newKK 
(KK 
)KK 
{LL 
GuestCalculationsMM %
=MM& '
guestCalculationsMM( 9
,MM9 :
UserCalculationsNN $
=NN% &
userCalculationsNN' 7
,NN7 8

TotalItemsOO 
=OO  
itemsOO! &
.OO& '
SelectOO' -
(OO- .
xOO. /
=>OO0 2
xOO3 4
.OO4 5
QuantityOO5 =
)OO= >
.OO> ?
SumOO? B
(OOB C
)OOC D
,OOD E
TotalAmountPP 
=PP  !
itemsPP" '
.PP' (
SelectPP( .
(PP. /
xPP/ 0
=>PP1 3
xPP4 5
.PP5 6
PricePP6 ;
)PP; <
.PP< =
SumPP= @
(PP@ A
)PPA B
}QQ 
}RR 
;RR 
}SS 	
catchTT 
(TT 
	ExceptionTT 
)TT 
{UU 	
returnVV 
newVV 
(VV 
)VV 
{VV 
SuccessVV "
=VV# $
falseVV% *
,VV* +
MessageVV, 3
=VV4 5
$strVV6 l
}VVm n
;VVn o
}WW 	
}XX 
}YY π$
IC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\User\UserRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
User" &
;& '
public 
class 
UserRepository 
: 
IUserRepository -
{ 
private 
readonly	 
IRepository 
_repository )
;) *
public

 
UserRepository

 
(

 
IRepository 

repository 
) 
{ 
_repository 
= 

repository 
; 
} 
public 
async 
Task 
< 
	UserBasic 
> 
GetByUsernameAsync 0
(0 1
string1 7
username8 @
)@ A
{ 
var 
query 
= 
$str ?
;? @
return 
await	 
_repository 
. 

QueryAsync %
<% &
	UserBasic& /
,/ 0
dynamic1 8
>8 9
(9 :
query: ?
,? @
newA D
{E F
UsernameG O
=P Q
usernameR Z
}[ \
)\ ]
;] ^
} 
public 
async 
Task 
< 
	UserBasic 
> 
GetByEmailAsync -
(- .
string. 4
email5 :
): ;
{ 
var 
sql 	
=
 
$str 7
;7 8
return 
await	 
_repository 
. 

QueryAsync %
<% &
	UserBasic& /
,/ 0
dynamic1 8
>8 9
(9 :
sql: =
,= >
new? B
{C D
EmailE J
=K L
emailM R
}S T
)T U
;U V
} 
public 
async 
Task 
< 
int 
> 
InsertAsync #
(# $
	UserBasic$ -
user. 2
)2 3
{   
var!! 
sql!! 
=!! 
$str!$ %
;$$% &
return&& 
await&& 
_repository&&  
.&&  !

QueryAsync&&! +
<&&+ ,
int&&, /
,&&/ 0
dynamic&&1 8
>&&8 9
(&&9 :
sql&&: =
,&&= >
new&&? B
{'' 	
Username(( 
=(( 
user(( 
.(( 
Username(( $
,(($ %
Password)) 
=)) 
user)) 
.)) 
Password)) $
,))$ %
Email** 
=** 
user** 
.** 
Email** 
}++ 	
)++	 

;++
 
},, 
public.. 
async.. 
Task.. 
<.. 
	UserBasic.. 
>.. 
GetByIdAsync.. *
(..* +
int..+ .
id../ 1
)..1 2
{// 
var00 
sql00 
=00 
$str00 7
;007 8
return22 
await22 
_repository22  
.22  !

QueryAsync22! +
<22+ ,
	UserBasic22, 5
,225 6
dynamic227 >
>22> ?
(22? @
sql22@ C
,22C D
new22E H
{22I J
Id22K M
=22N O
id22P R
}22S T
)22T U
;22U V
}33 
public55 
async55 
Task55 
UpdateUserAsync55 "
(55" #
	UserBasic55# ,
updatedUser55- 8
)558 9
{66 
var77 
sql77 
=77 
$str7< 
;<< 
await>> 
_repository>> 
.>> 
ExecuteAsync>> &
<>>& '
dynamic>>' .
>>>. /
(>>/ 0
sql>>0 3
,>>3 4
new>>5 8
{?? 	
Username@@ 
=@@ 
updatedUser@@ "
.@@" #
Username@@# +
,@@+ ,
PasswordAA 
=AA 
updatedUserAA "
.AA" #
PasswordAA# +
,AA+ ,
EmailBB 
=BB 
updatedUserBB 
.BB  
EmailBB  %
,BB% &
IdCC 
=CC 
updatedUserCC 
.CC 
IDCC 
}DD 	
)DD	 

;DD
 
}EE 
}FF Ø	
JC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\User\IUserRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
User" &
;& '
public 
	interface 
IUserRepository  
{ 
Task 
< 	
	UserBasic	 
> 
GetByUsernameAsync &
(& '
string' -
username. 6
)6 7
;7 8
Task		 
<		 	
	UserBasic			 
>		 
GetByEmailAsync		 #
(		# $
string		$ *
email		+ 0
)		0 1
;		1 2
Task

 
<

 	
int

	 
>

 
InsertAsync

 
(

 
	UserBasic

 #
user

$ (
)

( )
;

) *
Task 
< 	
	UserBasic	 
> 
GetByIdAsync  
(  !
int! $
id% '
)' (
;( )
Task 
UpdateUserAsync	 
( 
	UserBasic "
updatedUser# .
). /
;/ 0
} Û
@C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Repository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
;! "
public

 
class

 

Repository

 
:

 
IRepository

 %
{ 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
public 

Repository 
( 
IConfiguration 
configuration 
) 
{ 
_configuration 
= 
configuration  
;  !
} 
public 

async 
Task 
< 
IEnumerable !
<! "
TRes" &
>& '
>' (
QueryListAsync) 7
<7 8
TRes8 <
,< =
T> ?
>? @
(@ A
stringA G
commandH O
,O P
TQ R

parametersS ]
)] ^
{ 
using 
IDbConnection 

connection &
=' (
new) ,
MySqlConnection- <
(< =
_configuration= K
.K L
GetConnectionStringL _
(_ `
$str` j
)j k
)k l
;l m
return 
await 

connection 
.  

QueryAsync  *
<* +
TRes+ /
>/ 0
(0 1
command1 8
,8 9

parameters: D
,D E
commandTypeF Q
:Q R
CommandTypeS ^
.^ _
Text_ c
)c d
;d e
} 
public 

async 
Task 
< 
TRes 
> 

QueryAsync &
<& '
TRes' +
,+ ,
T- .
>. /
(/ 0
string0 6
command7 >
,> ?
T@ A

parametersB L
)L M
{ 
using 
IDbConnection 

connection &
=' (
new) ,
MySqlConnection- <
(< =
_configuration= K
.K L
GetConnectionStringL _
(_ `
$str` j
)j k
)k l
;l m
return 
await 

connection 
.  %
QuerySingleOrDefaultAsync  9
<9 :
TRes: >
>> ?
(? @
command@ G
,G H

parametersI S
,S T
commandTypeU `
:` a
CommandTypeb m
.m n
Textn r
)r s
;s t
} 
public!! 

async!! 
Task!! 
ExecuteAsync!! "
<!!" #
T!!# $
>!!$ %
(!!% &
string!!& ,
command!!- 4
,!!4 5
T!!6 7

parameters!!8 B
)!!B C
{"" 
using## 
IDbConnection## 

connection## &
=##' (
new##) ,
MySqlConnection##- <
(##< =
_configuration##= K
.##K L
GetConnectionString##L _
(##_ `
$str##` j
)##j k
)##k l
;##l m
await$$ 

connection$$ 
.$$ 
ExecuteAsync$$ %
($$% &
command$$& -
,$$- .

parameters$$/ 9
,$$9 :
commandType$$; F
:$$F G
CommandType$$H S
.$$S T
Text$$T X
)$$X Y
;$$Y Z
}%% 
}&& Ö
YC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Registration\RegistrationRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Registration" .
;. /
public 
class "
RegistrationRepository #
:$ %#
IRegistrationRepository& =
{ 
private 
readonly 
IRepository  
_repository! ,
;, -
public

 
"
RegistrationRepository

 !
(

! "
IRepository 

repository 
) 	
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
< 
int 
> 
InsertAsync &
(& '
RegistrationBasic' 8
registration9 E
)E F
{ 
var 
sql 
= 
$str %
;% &
return 
await 
_repository  
.  !

QueryAsync! +
<+ ,
int, /
,/ 0
dynamic1 8
>8 9
(9 :
sql: =
,= >
new? B
{ 	
UserID 
= 
registration !
.! "
UserID" (
,( )
Username 
= 
registration #
.# $
Username$ ,
,, -
Password 
= 
registration #
.# $
Password$ ,
,, -
Email 
= 
registration  
.  !
Email! &
,& '
AuthCode 
= 
registration #
.# $
AuthCode$ ,
} 	
)	 

;
 
}   
public"" 

async"" 
Task"" 
<"" 
RegistrationBasic"" '
>""' (
GetByID"") 0
(""0 1
int""1 4
id""5 7
)""7 8
{## 
var$$ 
sql$$ 
=$$ 
$str$$ ?
;$$? @
return&& 
await&& 
_repository&&  
.&&  !

QueryAsync&&! +
<&&+ ,
RegistrationBasic&&, =
,&&= >
dynamic&&? F
>&&F G
(&&G H
sql&&H K
,&&K L
new&&M P
{&&Q R
Id&&S U
=&&V W
id&&X Z
}&&[ \
)&&\ ]
;&&] ^
}'' 
public)) 

async)) 
Task)) !
AddUserToRegistration)) +
())+ ,
int)), /
id))0 2
,))2 3
int))4 7
userId))8 >
)))> ?
{** 
var++ 
sql++ 
=++ 
$str++ M
;++M N
await-- 
_repository-- 
.-- 
ExecuteAsync-- &
<--& '
dynamic--' .
>--. /
(--/ 0
sql--0 3
,--3 4
new--5 8
{--9 :
UserId--; A
=--B C
userId--D J
,--J K
Id--L N
=--O P
id--Q S
}--T U
)--U V
;--V W
}.. 
}// ó
ZC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Registration\IRegistrationRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Registration" .
;. /
public 
	interface #
IRegistrationRepository (
{ 
Task 
< 	
int	 
> 
InsertAsync 
( 
RegistrationBasic +
registration, 8
)8 9
;9 :
Task		 
<		 	
RegistrationBasic			 
>		 
GetByID		 #
(		# $
int		$ '
id		( *
)		* +
;		+ ,
Task

 !
AddUserToRegistration

	 
(

 
int

 "
id

# %
,

% &
int

' *
userId

+ 1
)

1 2
;

2 3
} Ö
[C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\PasswordReset\PasswordResetRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
PasswordReset" /
;/ 0
public 
class #
PasswordResetRepository $
:% &$
IPasswordResetRepository' ?
{ 
private 
readonly	 
IRepository 
_repository )
;) *
public		 #
PasswordResetRepository		 
(		  
IRepository

 

repository

 
) 
{ 
_repository 
= 

repository 
; 
} 
public 
async 
Task 
< 
string 
> 
GetCodeAsync '
(' (
int( +
userId, 2
)2 3
{ 
var 
query 
= 
$str 
; 
return 
await	 
_repository 
. 

QueryAsync %
<% &
string& ,
,, -
dynamic. 5
>5 6
(6 7
query7 <
,< =
new> A
{B C
UserIdD J
=K L
userIdM S
}T U
)U V
;V W
} 
public 
async 
Task 
InsertCodeAsync "
(" #
int# &
userId' -
,- .
string/ 5
recoveryCode6 B
)B C
{ 
var 
query 
= 
$str 
; 
await!! 
_repository!! 
.!! 
ExecuteAsync!!  
<!!  !
dynamic!!! (
>!!( )
(!!) *
query!!* /
,!!/ 0
new!!1 4
{!!5 6
UserId!!7 =
=!!> ?
userId!!@ F
,!!F G
RecoveryCode!!H T
=!!U V
recoveryCode!!W c
}!!d e
)!!e f
;!!f g
}"" 
}## ‡
\C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\PasswordReset\IPasswordResetRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
PasswordReset" /
;/ 0
public 
	interface $
IPasswordResetRepository )
{ 
Task 
InsertCodeAsync	 
( 
int 
userId #
,# $
string% +
recoveryCode, 8
)8 9
;9 :
Task 
< 	
string	 
> 
GetCodeAsync 
( 
int !
userId" (
)( )
;) *
}		 ≥
ZC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Notifications\NotificationRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Notifications" /
;/ 0
public 
class "
NotificationRepository #
:$ %#
INotificationRepository& =
{		 
private

 
readonly

 
IRepository

  
_repository

! ,
;

, -
public 
"
NotificationRepository !
(! "
IRepository 

repository 
) 	
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
< 
int 
> 
InsertAsync &
(& '
Notification' 3
notification4 @
)@ A
{ 
var 
sql 
= 
$str %
;% &
return 
await 
_repository  
.  !

QueryAsync! +
<+ ,
int, /
,/ 0
dynamic1 8
>8 9
(9 :
sql: =
,= >
new? B
{ 	
SenderID 
= 
notification #
.# $
SenderID$ ,
,, -

ReceiverID 
= 
notification %
.% &

ReceiverID& 0
,0 1
GroupID 
= 
notification "
." #
GroupID# *
,* +
Type 
= 
notification 
.  
Type  $
,$ %
	Responded   
=   
false   
}!! 	
)!!	 

;!!
 
}"" 
public$$ 

async$$ 
Task$$ 
<$$ 
IEnumerable$$ !
<$$! "
Notification$$" .
>$$. /
>$$/ 0
	ListAsync$$1 :
($$: ;
int$$; >
userId$$? E
)$$E F
{%% 
var&& 
sql&& 
=&& 
$str&& K
;&&K L
return'' 
await'' 
_repository''  
.''  !
QueryListAsync''! /
<''/ 0
Notification''0 <
,''< =
dynamic''> E
>''E F
(''F G
sql''G J
,''J K
new''L O
{''P Q
UserID''R X
=''Y Z
userId''[ a
}''b c
)''c d
;''d e
}(( 
public** 

async** 
Task** 
<** 
Notification** "
>**" #
GetAsync**$ ,
(**, -
int**- 0
notificationId**1 ?
)**? @
{++ 
var,, 
sql,, 
=,, 
$str,, G
;,,G H
return-- 
await-- 
_repository--  
.--  !

QueryAsync--! +
<--+ ,
Notification--, 8
,--8 9
dynamic--: A
>--A B
(--B C
sql--C F
,--F G
new--H K
{--L M
ID--N P
=--Q R
notificationId--S a
}--b c
)--c d
;--d e
}.. 
public00 

async00 
Task00 
RespondAsync00 "
(00" #&
RespondNotificationRequest00# =
request00> E
)00E F
{11 
var22 
sql22 
=22 
$str22 S
;22S T
await33 
_repository33 
.33 
ExecuteAsync33 &
(33& '
sql33' *
,33* +
new33, /
{330 1
	Responded332 ;
=33< =
true33> B
,33B C
ID33D F
=33G H
request33I P
.33P Q
NotificationID33Q _
}33` a
)33a b
;33b c
}44 
}55 µ	
[C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Notifications\INotificationRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Notifications" /
;/ 0
public 
	interface #
INotificationRepository (
{		 
public

 

Task

 
<

 
int

 
>

 
InsertAsync

  
(

  !
Notification

! -
notification

. :
)

: ;
;

; <
public 

Task 
< 
IEnumerable 
< 
Notification (
>( )
>) *
	ListAsync+ 4
(4 5
int5 8
userId9 ?
)? @
;@ A
public 

Task 
RespondAsync 
( &
RespondNotificationRequest 7
request8 ?
)? @
;@ A
public 

Task 
< 
Notification 
> 
GetAsync &
(& '
int' *
notificationId+ 9
)9 :
;: ;
} ¯
KC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Items\ItemsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Items" '
;' (
public 
class 
ItemsRepository 
: 
IItemsRepository /
{		 
private

 
readonly

	 
IRepository

 
_repository

 )
;

) *
public 
ItemsRepository 
( 
IRepository 

repository 
) 
{ 
_repository 
= 

repository 
; 
} 
public 

async 
Task 
< 
int 
> 
InsertAsync &
(& '
	ItemBasic' 0
item1 5
)5 6
{ 
var 
sql 	
=
 
$str 
; 
return 
await 
_repository  
.  !

QueryAsync! +
<+ ,
int, /
,/ 0
dynamic1 8
>8 9
(9 :
sql: =
,= >
item? C
.C D
MapValuesFromEntityD W
(W X
)X Y
)Y Z
;Z [
} 
public 
async 
Task 
< 
	ItemBasic 
> 
GetAsync &
(& '
int' *
itemId+ 1
)1 2
{ 
var 
sql 	
=
 
$str  
;   
return"" 
await""	 
_repository"" 
."" 

QueryAsync"" %
<""% &
	ItemBasic""& /
,""/ 0
dynamic""1 8
>""8 9
(""9 :
sql"": =
,""= >
new""? B
{""C D
Id""E G
=""H I
itemId""J P
}""Q R
)""R S
;""S T
}## 
public%% 

async%% 
Task%% 
UpdateAsync%% !
(%%! "
	ItemBasic%%" +
item%%, 0
)%%0 1
{&& 
var'' 
sql'' 
='' 
$str', 
;,, 
await.. 
_repository.. 
... 
ExecuteAsync.. &
<..& '
dynamic..' .
>... /
(../ 0
sql..0 3
,..3 4
item..5 9
...9 :
MapValuesFromEntity..: M
(..M N
)..N O
)..O P
;..P Q
}// 
public11 

async11 
Task11 
<11 
IEnumerable11 !
<11! "
	ItemBasic11" +
>11+ ,
>11, -
GetByGroupAsync11. =
(11= >
int11> A
groupId11B I
)11I J
{22 
var33 
sql33 
=33 
$str35  
;55  !
return77 
await77 
_repository77  
.77  !
QueryListAsync77! /
<77/ 0
	ItemBasic770 9
,779 :
dynamic77; B
>77B C
(77C D
sql77D G
,77G H
new77I L
{77M N
GroupId77O V
=77W X
groupId77Y `
}77a b
)77b c
;77c d
}88 
public:: 

async:: 
Task:: 
DeleteAsync:: !
(::! "
int::" %
id::& (
)::( )
{;; 
var<< 
sql<< 
=<< 
$str<= 
;== 
await?? 
_repository?? 
.?? 
ExecuteAsync?? &
<??& '
dynamic??' .
>??. /
(??/ 0
sql??0 3
,??3 4
new??5 8
{??9 :
Id??; =
=??> ?
id??@ B
}??C D
)??D E
;??E F
}@@ 
}AA ˙
PC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Items\ItemMemberRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Items" '
;' (
public 
class  
ItemMemberRepository !
:" #!
IItemMemberRepository$ 9
{		 
private

 
readonly

	 
IRepository

 
_repository

 )
;

) *
public  
ItemMemberRepository 
( 
IRepository 

repository 
) 
{ 
_repository 
= 

repository 
; 
} 
public 
async 
Task 
InsertAsync 
( 
ItemMemberBasic .

itemMember/ 9
)9 :
{ 
var 
sql 	
=
 
$str *
;* +
await 
_repository 
. 
ExecuteAsync  
<  !
dynamic! (
>( )
() *
sql* -
,- .

itemMember/ 9
.9 :
MapValuesFromEntity: M
(M N
)N O
)O P
;P Q
} 
public 
async 
Task 
< 
IEnumerable 
< 
ItemMemberBasic .
>. /
>/ 0
GetListAsync1 =
(= >
int> A
itemidB H
)H I
{ 
var 
sql 	
=
 
$str 
;  
return!! 
await!!	 
_repository!! 
.!! 
QueryListAsync!! )
<!!) *
ItemMemberBasic!!* 9
,!!9 :
dynamic!!; B
>!!B C
(!!C D
sql!!D G
,!!G H
new!!I L
{!!M N
ItemId!!O U
=!!V W
itemid!!X ^
}!!_ `
)!!` a
;!!a b
}"" 
public$$ 

async$$ 
Task$$ 
DeleteGuestAsync$$ &
($$& '
int$$' *
guestId$$+ 2
)$$2 3
{%% 
var&& 
sql&& 
=&& 
$str&' !
;''! "
await)) 
_repository)) 
.)) 
ExecuteAsync)) %
<))% &
dynamic))& -
>))- .
()). /
sql))/ 2
,))2 3
new))4 7
{))8 9
GuestId)): A
=))B C
guestId))D K
}))L M
)))M N
;))N O
}** 
public,, 

async,, 
Task,, 
DeleteUserAsync,, %
(,,% &
int,,& )
userId,,* 0
),,0 1
{-- 
var.. 
sql.. 
=.. 
$str./ 
;//  
await11 
_repository11 
.11 
ExecuteAsync11 &
<11& '
dynamic11' .
>11. /
(11/ 0
sql110 3
,113 4
new115 8
{119 :
UserId11; A
=11B C
userId11D J
}11K L
)11L M
;11M N
}22 
public44 
async44 
Task44 
DeleteByItemId44 !
(44! "
int44" %
itemId44& ,
)44, -
{55 
var66 
sql66 	
=66
 
$str67 
;77 
await99 
_repository99 
.99 
ExecuteAsync99  
<99  !
dynamic99! (
>99( )
(99) *
sql99* -
,99- .
new99/ 2
{993 4
ItemId995 ;
=99< =
itemId99> D
}99E F
)99F G
;99G H
}:: 
};; ô	
LC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Items\IItemsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Items" '
;' (
public 
	interface 
IItemsRepository !
{ 
Task		 
<		 	
int			 
>		 
InsertAsync		 
(		 
	ItemBasic		 #
item		$ (
)		( )
;		) *
Task

 
<

 	
	ItemBasic

	 
>

 
GetAsync

 
(

 
int

  
itemId

! '
)

' (
;

( )
Task 
UpdateAsync	 
( 
	ItemBasic 
item #
)# $
;$ %
Task 
< 	
IEnumerable	 
< 
	ItemBasic 
> 
>  
GetByGroupAsync! 0
(0 1
int1 4
groupId5 <
)< =
;= >
Task 
DeleteAsync	 
( 
int 
id 
) 
; 
} ›
QC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Items\IItemMemberRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Items" '
;' (
public 
	interface !
IItemMemberRepository &
{ 
Task		 
InsertAsync			 
(		 
ItemMemberBasic		 $

itemMember		% /
)		/ 0
;		0 1
Task

 
<

 	
IEnumerable

	 
<

 
ItemMemberBasic

 $
>

$ %
>

% &
GetListAsync

' 3
(

3 4
int

4 7
itemid

8 >
)

> ?
;

? @
Task 
DeleteGuestAsync	 
( 
int 
guestId %
)% &
;& '
Task 
DeleteUserAsync	 
( 
int 
userId #
)# $
;$ %
Task 
DeleteByItemId	 
( 
int 
itemId "
)" #
;# $
} ®	
AC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\IRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
;! "
public 
	interface 
IRepository 
{ 
Task 
< 	
IEnumerable	 
< 
TRes 
> 
> 
QueryListAsync *
<* +
TRes+ /
,/ 0
T1 2
>2 3
(3 4
string4 :
command; B
,B C
TD E

parametersF P
)P Q
;Q R
Task		 
<		 	
TRes			 
>		 

QueryAsync		 
<		 
TRes		 
,		 
T		  !
>		! "
(		" #
string		# )
command		* 1
,		1 2
T		3 4

parameters		5 ?
)		? @
;		@ A
Task

 
ExecuteAsync

	 
<

 
T

 
>

 
(

 
string

 
command

  '
,

' (
T

) *

parameters

+ 5
)

5 6
;

6 7
} Í
NC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Guests\IGuestsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Guests" (
;( )
public 
	interface 
IGuestsRepository "
{ 
Task		 
<		 	
IEnumerable			 
<		 
Guest		 
>		 
>		 
GetByGroupID		 )
(		) *
int		* -
groupId		. 5
)		5 6
;		6 7
Task

 
<

 	
int

	 
>

 
InsertAsync

 
(

 
Guest

 
guest

  %
)

% &
;

& '
} Ê
MC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Guests\GuestsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Guests" (
;( )
public 
class 
GuestsRepository 
: 
IGuestsRepository  1
{ 
private		 
readonly		 
IRepository		  
_repository		! ,
;		, -
public 

GuestsRepository 
( 
IRepository 

repository 
) 	
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
< 
IEnumerable !
<! "
Guest" '
>' (
>( )
GetByGroupID* 6
(6 7
int7 :
groupId; B
)B C
{ 
var 
sql 
= 
$str &
;& '
return 
await 
_repository  
.  !
QueryListAsync! /
</ 0
Guest0 5
,5 6
dynamic7 >
>> ?
(? @
sql@ C
,C D
newE H
{I J
GroupIDK R
=S T
groupIdU \
}] ^
)^ _
;_ `
} 
public 

async 
Task 
< 
int 
> 
InsertAsync &
(& '
Guest' ,
guest- 2
)2 3
{ 
var 
sql 
= 
$str  %
;  % &
return"" 
await"" 
_repository""  
.""  !

QueryAsync""! +
<""+ ,
int"", /
,""/ 0
dynamic""1 8
>""8 9
(""9 :
sql"": =
,""= >
new""? B
{""C D
Name""E I
=""J K
guest""L Q
.""Q R
Name""R V
,""V W
GroupID""X _
=""` a
guest""b g
.""g h
GroupID""h o
}""p q
)""q r
;""r s
}## 
}$$ ¶	
NC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Groups\IGroupsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Groups" (
;( )
public 
	interface 
IGroupsRepository "
{ 
Task		 
<		 	
IEnumerable			 
<		 

GroupBasic		 
>		  
>		  !
GetUserGroupsAsync		" 4
(		4 5
int		5 8
userId		9 ?
)		? @
;		@ A
Task

 
<

 	

GroupBasic

	 
>

 
GetGroupAsync

 "
(

" #
int

# &
id

' )
)

) *
;

* +
Task 
< 	
int	 
> 
InsertAsync 
( 

GroupBasic $
group% *
)* +
;+ ,
Task 
UpdateAsync	 
( 

GroupBasic 
group  %
)% &
;& '
Task 
DeleteAsync	 
( 
int 
id 
) 
; 
} ê"
MC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Groups\GroupsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Groups" (
;( )
public 
class 
GroupsRepository 
: 
IGroupsRepository  1
{ 
private		 
readonly		 
IRepository		  
_repository		! ,
;		, -
public 

GroupsRepository 
( 
IRepository 

repository 
) 	
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
< 
IEnumerable !
<! "

GroupBasic" ,
>, -
>- .
GetUserGroupsAsync/ A
(A B
intB E
userIdF L
)L M
{ 
var 
sql 
= 
$str (
;( )
return 
await 
_repository  
.  !
QueryListAsync! /
</ 0

GroupBasic0 :
,: ;
dynamic< C
>C D
(D E
sqlE H
,H I
newJ M
{N O
UserIDP V
=W X
userIdY _
}` a
)a b
;b c
} 
public   

async   
Task   
<   

GroupBasic    
>    !
GetGroupAsync  " /
(  / 0
int  0 3
id  4 6
)  6 7
{!! 
var"" 
sql"" 
="" 
$str"% 
;%% 
return'' 
await'' 
_repository''  
.''  !

QueryAsync''! +
<''+ ,

GroupBasic'', 6
,''6 7
dynamic''8 ?
>''? @
(''@ A
sql''A D
,''D E
new''F I
{''J K
Id''L N
=''O P
id''Q S
}''T U
)''U V
;''V W
}(( 
public** 

async** 
Task** 
<** 
int** 
>** 
InsertAsync** &
(**& '

GroupBasic**' 1
group**2 7
)**7 8
{++ 
var,, 
sql,, 
=,, 
$str,/ %
;//% &
return11 
await11 
_repository11  
.11  !

QueryAsync11! +
<11+ ,
int11, /
,11/ 0
dynamic111 8
>118 9
(119 :
sql11: =
,11= >
new11? B
{11C D
Name11E I
=11J K
group11L Q
.11Q R
Name11R V
,11V W
OwnerUserId11X c
=11d e
group11f k
.11k l
OwnerUserID11l w
}11x y
)11y z
;11z {
}22 
public44 

async44 
Task44 
UpdateAsync44 !
(44! "

GroupBasic44" ,
group44- 2
)442 3
{55 
var66 
sql66 
=66 
$str69 
;99 
await;; 
_repository;; 
.;; 
ExecuteAsync;; &
<;;& '
dynamic;;' .
>;;. /
(;;/ 0
sql;;0 3
,;;3 4
new;;5 8
{;;9 :
Id;;; =
=;;> ?
group;;@ E
.;;E F
ID;;F H
,;;H I
Name;;J N
=;;O P
group;;Q V
.;;V W
Name;;W [
,;;[ \
OwnerUserId;;] h
=;;i j
group;;k p
.;;p q
OwnerUserID;;q |
};;} ~
);;~ 
;	;; Ä
}<< 
public>> 

async>> 
Task>> 
DeleteAsync>> !
(>>! "
int>>" %
id>>& (
)>>( )
{?? 
var@@ 
sql@@ 
=@@ 
$str@B 
;BB 
awaitDD 
_repositoryDD 
.DD 
ExecuteAsyncDD &
<DD& '
dynamicDD' .
>DD. /
(DD/ 0
sqlDD0 3
,DD3 4
newDD5 8
{DD9 :
IdDD; =
=DD> ?
idDD@ B
}DDC D
)DDD E
;DDE F
}EE 
}FF »
YC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\GroupMembers\GroupMembersRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
GroupMembers" .
;. /
public 
class "
GroupMembersRepository #
:$ %#
IGroupMembersRepository& =
{ 
private		 
readonly		 
IRepository		  
_repository		! ,
;		, -
public 
"
GroupMembersRepository !
(! "
IRepository 

repository 
) 	
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
AddGroupMemberAsync )
() *
int* -
userId. 4
,4 5
int6 9
groupId: A
)A B
{ 
var 
sql 
= 
$str /
; 	
await 
_repository 
. 
ExecuteAsync &
<& '
dynamic' .
>. /
(/ 0
sql0 3
,3 4
new5 8
{9 :
GroupId; B
=C D
groupIdE L
,L M
UserIdN T
=U V
userIdW ]
}^ _
)_ `
;` a
} 
public 

async 
Task !
DeleteGroupGuestAsync +
(+ ,
int, /
guestId0 7
,7 8
int9 <
groupId= D
)D E
{ 
var 
sql 
= 
$str 7
;   	
await"" 
_repository"" 
."" 
ExecuteAsync"" &
<""& '
dynamic""' .
>"". /
(""/ 0
sql""0 3
,""3 4
new""5 8
{""9 :
GuestId""; B
=""C D
guestId""E L
,""L M
GroupId""N U
=""V W
groupId""X _
}""_ `
)""` a
;""a b
}## 
public%% 

async%% 
Task%% "
DeleteGroupMemberAsync%% ,
(%%, -
int%%- 0
userId%%1 7
,%%7 8
int%%9 <
groupId%%= D
)%%D E
{&& 
var'' 
sql'' 
='' 
$str') ;
;)); <
await++ 
_repository++ 
.++ 
ExecuteAsync++ &
<++& '
dynamic++' .
>++. /
(++/ 0
sql++0 3
,++3 4
new++5 8
{++9 :
UserID++; A
=++B C
userId++D J
,++J K
GroupID++L S
=++T U
groupId++V ]
}++^ _
)++_ `
;++` a
},, 
public.. 

async.. 
Task.. 
<.. 
IEnumerable.. !
<..! "
GroupMember.." -
>..- .
>... /
GetByGroupIDAsync..0 A
(..A B
int..B E
groupId..F M
)..M N
{// 
var00 
sql00 
=00 
$str04 (
;44( )
return66 
await66 
_repository66  
.66  !
QueryListAsync66! /
<66/ 0
GroupMember660 ;
,66; <
dynamic66= D
>66D E
(66E F
sql66F I
,66I J
new66K N
{66O P
GroupID66Q X
=66Y Z
groupId66[ b
}66c d
)66d e
;66e f
}77 
}88 ©	
PC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Friends\IFriendsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Friends" )
;) *
public 
	interface 
IFriendsRepository #
{ 
Task		 
<		 	
IEnumerable			 
<		 
UserMinimal		  
>		  !
>		! "
GetFriendListAsync		# 5
(		5 6
int		6 9
userId		: @
)		@ A
;		A B
Task

 
DeleteFriendAsync

	 
(

 
int

 
userId

 %
,

% &
int

' *
friendId

+ 3
)

3 4
;

4 5
Task 
< 	
IEnumerable	 
< 
UserMinimal  
>  !
>! "
FindFriendAsync# 2
(2 3
string3 9
input: ?
)? @
;@ A
Task 
InsertAsync	 
( 
int 
userId 
,  
int! $
friendId% -
)- .
;. /
} è	
ZC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\GroupMembers\IGroupMembersRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
GroupMembers" .
;. /
public 
	interface #
IGroupMembersRepository (
{ 
Task		 !
DeleteGroupGuestAsync			 
(		 
int		 "
guestId		# *
,		* +
int		, /
iD		0 2
)		2 3
;		3 4
Task

 "
DeleteGroupMemberAsync

	 
(

  
int

  #
userId

$ *
,

* +
int

, /
groupId

0 7
)

7 8
;

8 9
Task 
< 	
IEnumerable	 
< 
GroupMember  
>  !
>! "
GetByGroupIDAsync# 4
(4 5
int5 8
groupId9 @
)@ A
;A B
Task 
AddGroupMemberAsync	 
( 
int  
userId! '
,' (
int) ,
groupId- 4
)4 5
;5 6
} æ
OC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Repositories\Friends\FriendsRepository.cs
	namespace 	
KTPS
 
. 
Model 
. 
Repositories !
.! "
Friends" )
;) *
public 
class 
FriendsRepository 
:  
IFriendsRepository! 3
{ 
private		 
readonly		 
IRepository		  
_repository		! ,
;		, -
public 

FriendsRepository 
( 
IRepository 

repository 
) 	
{ 
_repository 
= 

repository  
;  !
} 
public 

async 
Task 
< 
IEnumerable !
<! "
UserMinimal" -
>- .
>. /
GetFriendListAsync0 B
(B C
intC F
userIdG M
)M N
{ 
var 
sql 
= 
$str *
;* +
return 
await 
_repository  
.  !
QueryListAsync! /
</ 0
UserMinimal0 ;
,; <
dynamic= D
>D E
(E F
sqlF I
,I J
newK N
{O P
IDQ S
=T U
userIdV \
}] ^
)^ _
;_ `
} 
public 

async 
Task 
DeleteFriendAsync '
(' (
int( +
userId, 2
,2 3
int4 7
friendId8 @
)@ A
{ 
var 
sql 
= 
$str  =
;  = >
await"" 
_repository"" 
."" 
ExecuteAsync"" &
<""& '
dynamic""' .
>"". /
(""/ 0
sql""0 3
,""3 4
new""5 8
{""9 :
UserID""; A
=""B C
userId""D J
,""J K
FriendID""L T
=""U V
friendId""W _
}""` a
)""a b
;""b c
}## 
public%% 

async%% 
Task%% 
<%% 
IEnumerable%% !
<%%! "
UserMinimal%%" -
>%%- .
>%%. /
FindFriendAsync%%0 ?
(%%? @
string%%@ F
input%%G L
)%%L M
{&& 
var'' 
sql'' 
='' 
@$"'' 
$str') "
{))" #
input))# (
}))( )
$str))) +
"))+ ,
;)), -
return++ 
await++ 
_repository++  
.++  !
QueryListAsync++! /
<++/ 0
UserMinimal++0 ;
,++; <
dynamic++= D
>++D E
(++E F
sql++F I
,++I J
new++K N
{++O P
}++Q R
)++R S
;++S T
},, 
public.. 

async.. 
Task.. 
InsertAsync.. !
(..! "
int.." %
userId..& ,
,.., -
int... 1
friendId..2 :
)..: ;
{// 
var00 
sql00 
=00 
$str02 )
;22) *
await44 
_repository44 
.44 
ExecuteAsync44 &
(44& '
sql44' *
,44* +
new44, /
{440 1
UserID442 8
=449 :
userId44; A
,44A B
FriendID44C K
=44L M
friendId44N V
}44W X
)44X Y
;44Y Z
}55 
}66 »
AC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Helpers\RepositoryHelper.cs
	namespace 	
KTPS
 
. 
Model 
. 
Helpers 
; 
public 
static 
class 
RepositoryHelper $
{ 
public 

static 
dynamic 
MapValuesFromEntity -
(- .
this. 2
object3 9
entity: @
)@ A
{		 
var

 
	variables

 
=

 
new

 

Dictionary

 &
<

& '
string

' -
,

- .
object

/ 5
>

5 6
(

6 7
)

7 8
;

8 9
var 

properties 
= 
entity 
.  
GetType  '
(' (
)( )
.) *
GetProperties* 7
(7 8
)8 9
.9 :
ToList: @
(@ A
)A B
;B C

properties 
. 
ForEach 
( 
x 
=> 
	variables  )
.) *
Add* -
(- .
x. /
./ 0
Name0 4
,4 5
x6 7
.7 8
GetValue8 @
(@ A
entityA G
)G H
)H I
)I J
;J K
return 
	variables 
; 
} 
} ﬂ

=C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Helpers\RandomString.cs
	namespace 	
KTPS
 
. 
Model 
. 
Helpers 
; 
public 
static 
class 
RandomString  
{ 
public 

static 
string  
GenerateRandomString -
(- .
). /
{		 
var

 
magickNumber

 
=

 
$num

 
;

 
const 
string 
chars 
= 
$str X
;X Y
Random 
random 
= 
new 
Random "
(" #
)# $
;$ %
return 
new 
string 
( 

Enumerable $
.$ %
Repeat% +
(+ ,
chars, 1
,1 2
magickNumber3 ?
)? @
.@ A
SelectA G
(G H
sH I
=>J L
sM N
[N O
randomO U
.U V
NextV Z
(Z [
s[ \
.\ ]
Length] c
)c d
]d e
)e f
.f g
ToArrayg n
(n o
)o p
)p q
;q r
} 
} È
BC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\User\UserMinimal.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
User "
;" #
public 
class 
UserMinimal 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
} Ç
?C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Helpers\PasswordHelper.cs
	namespace 	
KTPS
 
. 
Model 
. 
Helpers 
; 
public 
static 
class 
PasswordHelper "
{ 
public 

static 
string 
Hash 
( 
this "
string# )
password* 2
)2 3
{		 
using

 
(

 
var

 

sha256Hash

 
=

 
SHA256

  &
.

& '
Create

' -
(

- .
)

. /
)

/ 0
{ 	
var 
bytes 
= 

sha256Hash "
." #
ComputeHash# .
(. /
Encoding/ 7
.7 8
UTF88 <
.< =
GetBytes= E
(E F
passwordF N
)N O
)O P
;P Q
var 
builder 
= 
new 
StringBuilder +
(+ ,
), -
;- .
for 
( 
int 
i 
= 
$num 
; 
i 
< 
bytes  %
.% &
Length& ,
;, -
i. /
++/ 1
)1 2
builder 
. 
Append 
( 
bytes $
[$ %
i% &
]& '
.' (
ToString( 0
(0 1
$str1 5
)5 6
)6 7
;7 8
return 
builder 
. 
ToString #
(# $
)$ %
;% &
} 	
} 
} ì
@C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\User\UserBasic.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
User "
;" #
public 
class 
	UserBasic 
: 
UserMinimal $
{ 
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
} å
>C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\ServerResult.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
; 
public 
class 
ServerResult 
{ 
public 

bool 
Success 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Message 
{ 
get 
;  
set! $
;$ %
}& '
} 
public		 
class		 
ServerResult		 
<		 
T		 
>		 
:		 
ServerResult		 +
{

 
public 

T 
Data 
{ 
get 
; 
set 
; 
} 
} ë
SC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Responses\GetGroupMembersResponse.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
	Responses '
;' (
public 
class #
GetGroupMembersResponse $
{ 
public		 

int		 
OwnerUserID		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public

 

List

 
<

 
GroupMember

 
>

 
Members

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
public 

List 
< 
Guest 
> 
Guests 
{ 
get  #
;# $
set% (
;( )
}* +
} À
OC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Responses\CalculationResponse.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
	Responses '
;' (
public 
class 
CalculationResponse  
{ 
public 

List 
< 
GuestCalculation  
>  !
GuestCalculations" 3
{4 5
get6 9
;9 :
set; >
;> ?
}@ A
public		 

List		 
<		 
UserCalculation		 
>		  
UserCalculations		! 1
{		2 3
get		4 7
;		7 8
set		9 <
;		< =
}		> ?
public

 

int

 

TotalItems

 
{

 
get

 
;

  
set

! $
;

$ %
}

& '
public 

decimal 
TotalAmount 
{  
get! $
;$ %
set& )
;) *
}+ ,
} Æ
UC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\RespondNotificationRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class &
RespondNotificationRequest '
{ 
public 

int 
NotificationID 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
public 

bool 
Accept 
{ 
get 
; 
set !
;! "
}# $
} ß
OC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\ResetPasswordRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class  
ResetPasswordRequest !
{ 
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
public 

string 
NewPassword 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
	AuthCheck 
{ 
get !
;! "
set# &
;& '
}( )
} ì
SC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\ResetPasswordAuthRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class $
ResetPasswordAuthRequest %
{ 
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
public 

string 
RecoveryCode 
{  
get! $
;$ %
set& )
;) *
}+ ,
} Ò
TC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\RemoveGroupMembersRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class %
RemoveGroupMembersRequest &
{ 
public 

int 
? 
UserToRemoveID 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
? 
GuestToRemoveID 
{  !
get" %
;% &
set' *
;* +
}, -
public		 

int		 
GroupID		 
{		 
get		 
;		 
set		 !
;		! "
}		# $
public

 

int

 
RequestUserID

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
} ≠
SC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\RegistrationStartRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class $
RegistrationStartRequest %
{ 
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
} ï
RC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\RegistrationAuthRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class #
RegistrationAuthRequest $
{ 
public 

int 
RegistrationID 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
AuthCode 
{ 
get  
;  !
set" %
;% &
}' (
} ˘
JC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\NewGroupRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
NewGroupRequest 
{ 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
} ¸
GC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\LoginRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
LoginRequest 
{ 
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
} é
LC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\LeaveGroupRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
{ 
public 

class 
LeaveGroupRequest "
{ 
public 
int 
GroupID 
{ 
get  
;  !
set" %
;% &
}' (
public 
int 
UserID 
{ 
get 
;  
set! $
;$ %
}& '
} 
} Ô
PC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\ForgotPasswordRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class !
ForgotPasswordRequest "
{ 
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
} ˛
LC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\FindFriendRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
FindFriendRequest 
{ 
public 

string 
Input 
{ 
get 
; 
set "
;" #
}$ %
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
} Ω

JC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\EditItemRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
EditItemRequest 
{ 
public 

int 
ItemId 
{ 
get 
; 
set  
;  !
}" #
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public		 

int		 
Quantity		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public

 

decimal

 
Price

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
public 

List 
< 
int 
> 
GuestIds 
{ 
get  #
;# $
set% (
;( )
}* +
public 

List 
< 
int 
> 
UserIds 
{ 
get "
;" #
set$ '
;' (
}) *
} é
KC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\EditGroupRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
EditGroupRequest 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
} ˙
MC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\DeleteGroupRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
DeleteGroupRequest 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
} Ç
NC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\DeleteFriendRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
DeleteFriendRequest  
{ 
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
public 

int 
FriendID 
{ 
get 
; 
set "
;" #
}$ %
} —
TC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\CreateNotificationRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class %
CreateNotificationRequest &
{ 
public 

int 
SenderID 
{ 
get 
; 
set "
;" #
}$ %
public 

int 

ReceiverID 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 
? 
GroupId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Type 
{ 
get 
; 
set !
;! "
}# $
}		 ¬

LC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\CreateItemRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
CreateItemRequest 
{ 
public 

int 
GroupId 
{ 
get 
; 
set !
;! "
}# $
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public		 

int		 
Quantity		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public

 

decimal

 
Price

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
public 

List 
< 
int 
> 
GuestIds 
{ 
get  #
;# $
set% (
;( )
}* +
public 

List 
< 
int 
> 
UserIds 
{ 
get "
;" #
set$ '
;' (
}) *
} ˙
JC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Requests\AddGuestRequest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Requests &
;& '
public 
class 
AddGuestRequest 
{ 
public 

int 
GroupID 
{ 
get 
; 
set !
;! "
}# $
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
} ¸	
PC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Registration\RegistrationBasic.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Registration *
;* +
public 
class 
RegistrationBasic 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

int 
? 
UserID 
{ 
get 
; 
set !
;! "
}# $
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public		 

string		 
AuthCode		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
}

 Ô	
LC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Notifications\Notification.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Notifications +
;+ ,
public 
class 
Notification 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

int 
SenderID 
{ 
get 
; 
set "
;" #
}$ %
public 

int 

ReceiverID 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 
? 
GroupID 
{ 
get 
; 
set "
;" #
}$ %
public		 

string		 
Type		 
{		 
get		 
;		 
set		 !
;		! "
}		# $
public

 

bool

 
	responded

 
{

 
get

 
;

  
set

! $
;

$ %
}

& '
} ª
GC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Items\ItemMemberBasic.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Items #
;# $
public 
class 
ItemMemberBasic 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
ItemId 
{ 
get 
; 
set  
;  !
}" #
public 

int 
? 
GuestId 
{ 
get 
; 
set "
;" #
}$ %
public 

int 
? 
UserId 
{ 
get 
; 
set !
;! "
}# $
}		 Æ
AC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Items\ItemBasic.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Items #
;# $
public 
class 
	ItemBasic 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
GroupId 
{ 
get 
; 
set !
;! "
}# $
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

int 
Quantity 
{ 
get 
; 
set "
;" #
}$ %
public		 

decimal		 
Price		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
}

 ı
>C:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Guests\Guest.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Guests $
;$ %
public 
class 
Guest 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

int 
GroupID 
{ 
get 
; 
set !
;! "
}# $
} ú
DC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Groups\GroupMember.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Groups $
;$ %
public 
class 
GroupMember 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

int 
GroupID 
{ 
get 
; 
set !
;! "
}# $
public 

int 
UserID 
{ 
get 
; 
set  
;  !
}" #
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
}		 É
CC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Groups\GroupBasic.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Groups $
;$ %
public 
class 

GroupBasic 
{ 
public 

int 
ID 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

int 
OwnerUserID 
{ 
get  
;  !
set" %
;% &
}' (
} û
MC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Calculation\UserCalculation.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Calculation )
;) *
public 
class 
UserCalculation 
{ 
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

string 
Username 
{ 
get  
;  !
set" %
;% &
}' (
public 

decimal 
Amount 
{ 
get 
;  
set! $
;$ %
}& '
} ù
NC:\Users\PC\Desktop\KTPS-2\KTPS.Model\Entities\Calculation\GuestCalculation.cs
	namespace 	
KTPS
 
. 
Model 
. 
Entities 
. 
Calculation )
;) *
public 
class 
GuestCalculation 
{ 
public 

int 
GuestId 
{ 
get 
; 
set !
;! "
}# $
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

decimal 
Amount 
{ 
get 
;  
set! $
;$ %
}& '
} 