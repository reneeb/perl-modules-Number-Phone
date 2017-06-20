#!/usr/bin/perl -w

use Test::More;
END { done_testing }

use lib 't/inc';
use fatalwarnings;

use Number::Phone::Country qw(noexport);

sub phone2country { goto &Number::Phone::Country::phone2country }

# return nothing for nonsense country codes
ok(!defined(Number::Phone::Country::country_code("XX")), "N::P::C::country_code returns undef for a nonsense country code");
ok(!defined(Number::Phone::Country::idd_code("XX")),     "N::P::C::idd_code returns undef for a nonsense country code");
ok(!defined(Number::Phone::Country::ndd_code("XX")),     "N::P::C::ndd_code returns undef for a nonsense country code");

# NANP formats
is(phone2country(  "219-555-0199"), "US",   "NANP: xxx-xxx-xxxx format");
is(phone2country("(219) 555-0199"), "US",   "NANP: (xxx) xxx-xxxx format");
is(phone2country("1 219 555 0199"), "US",   "NANP: 1 xxx xxx xxxx format");
is(phone2country("1-219-555-0199"), "US",   "NANP: 1-xxx-xxx-xxxx format");
is(phone2country("1 219-555-0199"), "US",   "NANP: 1 xxx-xxx-xxxx format");
is(phone2country(  "+12195550199"), "US",   "NANP: +1xxxxxxxxxx format");

is(phone2country("1 800 555 0199"), "NANP", "NANP: toll-free number IDed as generic NANP number");

# NANP
# FIXME make sure a decent number of CA and US codes are covered!
is(phone2country("1 2042345678"), "CA", "NANP: CA: 204");
is(phone2country("1 2012345678"), "US", "NANP: US: 201");

# NANP little countries, in area code order
is(phone2country('1 242 555 0199'), 'BS', 'NANP: BS: 242');
is(phone2country('1 246 555 0199'), 'BB', 'NANP: BB: 246');
is(phone2country('1 264 555 0199'), 'AI', 'NANP: AI: 264');
is(phone2country('1 268 555 0199'), 'AG', 'NANP: AG: 268');
is(phone2country('1 284 555 0199'), 'VG', 'NANP: VG: 284');
is(phone2country('1 340 555 0199'), 'VI', 'NANP: VI: 340');
is(phone2country('1 345 555 0199'), 'KY', 'NANP: KY: 345');
is(phone2country('1 441 555 0199'), 'BM', 'NANP: BM: 441');
is(phone2country('1 473 555 0199'), 'GD', 'NANP: GD: 473');
is(phone2country('1 649 555 0199'), 'TC', 'NANP: TC: 649');
is(phone2country('1 664 555 0199'), 'MS', 'NANP: MS: 664');
is(phone2country('1 670 555 0199'), 'MP', 'NANP: MP: 670');
is(phone2country('1 671 555 0199'), 'GU', 'NANP: GU: 671');
is(phone2country('1 684 555 0199'), 'AS', 'NANP: AS: 684');
is(phone2country('1 721 555 0199'), 'SX', 'NANP: SX: 721');
is(phone2country('1 758 555 0199'), 'LC', 'NANP: LC: 758');
is(phone2country('1 767 555 0199'), 'DM', 'NANP: DM: 767');
is(phone2country('1 784 555 0199'), 'VC', 'NANP: VC: 784');
is(phone2country('1 787 555 0199'), 'PR', 'NANP: PR: 787');
is(phone2country('1 809 555 0199'), 'DO', 'NANP: DO: 809');
is(phone2country('1 829 555 0199'), 'DO', 'NANP: DO: 829');
is(phone2country('1 849 555 0199'), 'DO', 'NANP: DO: 849');
is(phone2country('1 868 555 0199'), 'TT', 'NANP: TT: 868');
is(phone2country('1 869 555 0199'), 'KN', 'NANP: KN: 869');
is(phone2country('1 876 555 0199'), 'JM', 'NANP: JM: 876');
is(phone2country('1 939 555 0199'), 'PR', 'NANP: PR: 939');

# Sometimes countries move around. Pesky things.
{ no warnings;
isnt(phone2country('+6841234567'), 'AS', "+684 *not* identified as AS");  # moved to NANP, +1 684
isnt(phone2country('+5995123'),    'SX', '+5995 *not* identified as SX'); # moved to NANP, +1 721
}

# FIXME - add Kazakhstan/Russia weirdness

print "# test some stupid formatting\n";
is(phone2country('+441234567890'), 'GB',      '+441234567890 is GB');
is(phone2country('+44 1234 567890'), 'GB',    '+44 1234 567890 is GB');
is(phone2country('+44 1234-567890'), 'GB',    '+44 1234-567890 is GB');
is(phone2country('+44 (0)1234 567890'), 'GB', '+44 (0)1234 567890 is GB');
is(phone2country('+4-4 845 00 DEVIL'), 'GB',  '+4-4 845 00 DEVIL is GB');

print "# regression tests for all other country codes start here\n";
is(phone2country('+20123') , 'EG', '+20 is EG');
is(phone2country('+211123'), 'SS', '+211 is SS');
is(phone2country('+212123'), 'MA', '+212 is MA');
is(phone2country('+2125288123'), 'EH', '+212 5288 is EH');
is(phone2country('+2125289123'), 'EH', '+212 5289 is EH');
is(phone2country('+213123'), 'DZ', '+213 is DZ');
is(phone2country('+216123'), 'TN', '+216 is TN');
is(phone2country('+218123'), 'LY', '+218 is LY');
is(phone2country('+220123'), 'GM', '+220 is GM');
is(phone2country('+221123'), 'SN', '+221 is SN');
is(phone2country('+222123'), 'MR', '+222 is MR');
is(phone2country('+223123'), 'ML', '+223 is ML');
is(phone2country('+224123'), 'GN', '+224 is GN');
is(phone2country('+225123'), 'CI', '+225 is CI');
is(phone2country('+226123'), 'BF', '+226 is BF');
is(phone2country('+227123'), 'NE', '+227 is NE');
is(phone2country('+228123'), 'TG', '+228 is TG');
is(phone2country('+229123'), 'BJ', '+229 is BJ');
is(phone2country('+230123'), 'MU', '+230 is MU');
is(phone2country('+231123'), 'LR', '+231 is LR');
is(phone2country('+232123'), 'SL', '+232 is SL');
is(phone2country('+233123'), 'GH', '+233 is GH');
is(phone2country('+234123'), 'NG', '+234 is NG');
is(phone2country('+235123'), 'TD', '+235 is TD');
is(phone2country('+236123'), 'CF', '+236 is CF');
is(phone2country('+237123'), 'CM', '+237 is CM');
is(phone2country('+238123'), 'CV', '+238 is CV');
is(phone2country('+239123'), 'ST', '+239 is ST');
is(phone2country('+240123'), 'GQ', '+240 is GQ');
is(phone2country('+241123'), 'GA', '+241 is GA');
is(phone2country('+242123'), 'CG', '+242 is CG');
is(phone2country('+243123'), 'CD', '+243 is CD');
is(phone2country('+244123'), 'AO', '+244 is AO');
is(phone2country('+245123'), 'GW', '+245 is GW');
is(phone2country('+246123'), 'IO', '+246 is IO');
is(phone2country('+247123'), 'AC', '+247 is AC');
is(phone2country('+248123'), 'SC', '+248 is SC');
is(phone2country('+249123'), 'SD', '+249 is SD');
is(phone2country('+250123'), 'RW', '+250 is RW');
is(phone2country('+251123'), 'ET', '+251 is ET');
is(phone2country('+252123'), 'SO', '+252 is SO');
is(phone2country('+253123'), 'DJ', '+253 is DJ');
is(phone2country('+254123'), 'KE', '+254 is KE');
is(phone2country('+255123'), 'TZ', '+255 is TZ');
is(phone2country('+256123'), 'UG', '+256 is UG');
is(phone2country('+257123'), 'BI', '+257 is BI');
is(phone2country('+258123'), 'MZ', '+258 is MZ');
is(phone2country('+260123'), 'ZM', '+260 is ZM');
is(phone2country('+261123'), 'MG', '+261 is MG');
is(phone2country('+262123'), 'RE', '+262 is RE');
is(phone2country('+2622691123') , 'YT', '+2622691 is YT');
is(phone2country('+26226960123'), 'YT', '+26226960 is YT');
is(phone2country('+26226961123'), 'YT', '+26226961 is YT');
is(phone2country('+26226962123'), 'YT', '+26226962 is YT');
is(phone2country('+26226963123'), 'YT', '+26226963 is YT');
is(phone2country('+26226964123'), 'YT', '+26226964 is YT');
is(phone2country('+26263920123'), 'YT', '+26263920 is YT');
is(phone2country('+26263921123'), 'YT', '+26263921 is YT');
is(phone2country('+26263922123'), 'YT', '+26263922 is YT');
is(phone2country('+26263923123'), 'YT', '+26263923 is YT');
is(phone2country('+26263924123'), 'YT', '+26263924 is YT');
is(phone2country('+26263965123'), 'YT', '+26263965 is YT');
is(phone2country('+26263966123'), 'YT', '+26263966 is YT');
is(phone2country('+26263967123'), 'YT', '+26263967 is YT');
is(phone2country('+26263968123'), 'YT', '+26263968 is YT');
is(phone2country('+26263969123'), 'YT', '+26263969 is YT');
is(phone2country('+263123'), 'ZW', '+263 is ZW');
is(phone2country('+264123'), 'NA', '+264 is NA');
is(phone2country('+265123'), 'MW', '+265 is MW');
is(phone2country('+266123'), 'LS', '+266 is LS');
is(phone2country('+267123'), 'BW', '+267 is BW');
is(phone2country('+268123'), 'SZ', '+268 is SZ');
is(phone2country('+269123'), 'KM', '+269 is KM');
is(phone2country('+27123') , 'ZA', '+27 is ZA');
is(phone2country('+290123'), 'SH', '+290 is SH');
is(phone2country('+291123'), 'ER', '+291 is ER');
is(phone2country('+297123'), 'AW', '+297 is AW');
is(phone2country('+298123'), 'FO', '+298 is FO');
is(phone2country('+299123'), 'GL', '+299 is GL');
is(phone2country('+30123') , 'GR', '+30 is GR');
is(phone2country('+31123') , 'NL', '+31 is NL');
is(phone2country('+32123') , 'BE', '+32 is BE');
is(phone2country('+33123') , 'FR', '+33 is FR');
is(phone2country('+34123') , 'ES', '+34 is ES');
is(phone2country('+350123'), 'GI', '+350 is GI');
is(phone2country('+351123'), 'PT', '+351 is PT');
is(phone2country('+352123'), 'LU', '+352 is LU');
is(phone2country('+353123'), 'IE', '+353 is IE');
is(phone2country('+35348123'), 'GB', '+35348 is GB'); # Northern Ireland, as part of Ireland
is(phone2country('+354123'), 'IS', '+354 is IS');
is(phone2country('+355123'), 'AL', '+355 is AL');
is(phone2country('+356123'), 'MT', '+356 is MT');
is(phone2country('+357123'), 'CY', '+357 is CY');
is(phone2country('+358123'), 'FI', '+358 is FI');
is(phone2country('+359123'), 'BG', '+359 is BG');
is(phone2country('+36123') , 'HU', '+36 is HU');
is(phone2country('+370123'), 'LT', '+370 is LT');
is(phone2country('+371123'), 'LV', '+371 is LV');
is(phone2country('+372123'), 'EE', '+372 is EE');
is(phone2country('+373123'), 'MD', '+373 is MD');
is(phone2country('+374123'), 'AM', '+374 is AM');
is(phone2country('+375123'), 'BY', '+375 is BY');
is(phone2country('+376123'), 'AD', '+376 is AD');
is(phone2country('+377123'), 'MC', '+377 is MC');
is(phone2country('+37744123'), 'XK', '+377 44 is XK');
is(phone2country('+37745123'), 'XK', '+377 45 is XK');
is(phone2country('+378123'), 'SM', '+378 is SM');
is(phone2country('+379123'), 'VA', '+379 is VA');
is(phone2country('+380123'), 'UA', '+380 is UA');
is(phone2country('+381123'), 'RS', '+381 is RS');
is(phone2country('+38128123'), 'XK', '+381 28 is XK');
is(phone2country('+38129123'), 'XK', '+381 29 is XK');
is(phone2country('+38138123'), 'XK', '+381 38 is XK');
is(phone2country('+38139123'), 'XK', '+381 39 is XK');
is(phone2country('+382123'), 'ME', '+382 is ME');
is(phone2country('+383123'), 'XK', '+383 is XK');
is(phone2country('+385123'), 'HR', '+385 is HR');
is(phone2country('+386123'), 'SI', '+386 is SI');
is(phone2country('+38643123'), 'XK', '+386 43 is XK');
is(phone2country('+38649123'), 'XK', '+386 44 is XK');
is(phone2country('+387123'), 'BA', '+387 is BA');
is(phone2country('+389123'), 'MK', '+389 is MK');
is(phone2country('+39123') , 'IT', '+39 is IT');
is(phone2country('+3966982123'), 'VA', '+3966982 is VA'); # Vatican, as part of Rome
is(phone2country('+40123') , 'RO', '+40 is RO');
is(phone2country('+41123') , 'CH', '+41 is CH');
is(phone2country('+420123'), 'CZ', '+420 is CZ');
is(phone2country('+421123'), 'SK', '+421 is SK');
is(phone2country('+423123'), 'LI', '+423 is LI');
is(phone2country('+43123') , 'AT', '+43 is AT');
is(phone2country('+44123') , 'GB', '+44 is GB');
is(phone2country('+45123') , 'DK', '+45 is DK');
is(phone2country('+46123') , 'SE', '+46 is SE');
is(phone2country('+47123') , 'NO', '+47 is NO');
is(phone2country('+48123') , 'PL', '+48 is PL');
is(phone2country('+49123') , 'DE', '+49 is DE');
is(phone2country('+500123'), 'FK', '+500 is FK');
is(phone2country('+501123'), 'BZ', '+501 is BZ');
is(phone2country('+502123'), 'GT', '+502 is GT');
is(phone2country('+503123'), 'SV', '+503 is SV');
is(phone2country('+504123'), 'HN', '+504 is HN');
is(phone2country('+505123'), 'NI', '+505 is NI');
is(phone2country('+506123'), 'CR', '+506 is CR');
is(phone2country('+507123'), 'PA', '+507 is PA');
is(phone2country('+508123'), 'PM', '+508 is PM');
is(phone2country('+509123'), 'HT', '+509 is HT');
is(phone2country('+51123') , 'PE', '+51 is PE');
is(phone2country('+52123') , 'MX', '+52 is MX');
is(phone2country('+53123') , 'CU', '+53 is CU');
is(phone2country('+54123') , 'AR', '+54 is AR');
is(phone2country('+55123') , 'BR', '+55 is BR');
is(phone2country('+56123') , 'CL', '+56 is CL');
is(phone2country('+57123') , 'CO', '+57 is CO');
is(phone2country('+58123') , 'VE', '+58 is VE');
is(phone2country('+590123'), 'GP', '+590 is GP');
is(phone2country('+591123'), 'BO', '+591 is BO');
is(phone2country('+592123'), 'GY', '+592 is GY');
is(phone2country('+593123'), 'EC', '+593 is EC');
is(phone2country('+594123'), 'GF', '+594 is GF');
is(phone2country('+595123'), 'PY', '+595 is PY');
is(phone2country('+596123'), 'MQ', '+596 is MQ');
is(phone2country('+597123'), 'SR', '+597 is SR');
is(phone2country('+598123'), 'UY', '+598 is UY');
is(phone2country('+599123'), 'BQ', '+599 is BQ');
is(phone2country('+5999123'), 'CW', '+5990 is CW');
is(phone2country('+60123') , 'MY', '+60 is MY');
is(phone2country('+61123') , 'AU', '+61 is AU');
is(phone2country('+6189162123'), 'CC', '+6189162 is CC');
is(phone2country('+6189164123'), 'CX', '+6189164 is CX');
is(phone2country('+62123') , 'ID', '+62 is ID');
is(phone2country('+63123') , 'PH', '+63 is PH');
is(phone2country('+64123') , 'NZ', '+64 is NZ');
is(phone2country('+65123') , 'SG', '+65 is SG');
is(phone2country('+66123') , 'TH', '+66 is TH');
is(phone2country('+670123'), 'TL', '+670 is TL');
is(phone2country('+67210123'), 'AQ', '+67210 is AQ');
is(phone2country('+67211123'), 'AQ', '+67211 is AQ');
is(phone2country('+67212123'), 'AQ', '+67212 is AQ');
is(phone2country('+67213123'), 'AQ', '+67213 is AQ');
is(phone2country('+6723123'), 'NF', '+6723 is NF');
is(phone2country('+673123'), 'BN', '+673 is BN');
is(phone2country('+674123'), 'NR', '+674 is NR');
is(phone2country('+675123'), 'PG', '+675 is PG');
is(phone2country('+676123'), 'TO', '+676 is TO');
is(phone2country('+677123'), 'SB', '+677 is SB');
is(phone2country('+678123'), 'VU', '+678 is VU');
is(phone2country('+679123'), 'FJ', '+679 is FJ');
is(phone2country('+680123'), 'PW', '+680 is PW');
is(phone2country('+681123'), 'WF', '+681 is WF');
is(phone2country('+682123'), 'CK', '+682 is CK');
is(phone2country('+683123'), 'NU', '+683 is NU');
is(phone2country('+685123'), 'WS', '+685 is WS');
is(phone2country('+686123'), 'KI', '+686 is KI');
is(phone2country('+687123'), 'NC', '+687 is NC');
is(phone2country('+688123'), 'TV', '+688 is TV');
is(phone2country('+689123'), 'PF', '+689 is PF');
is(phone2country('+690123'), 'TK', '+690 is TK');
is(phone2country('+691123'), 'FM', '+691 is FM');
is(phone2country('+692123'), 'MH', '+692 is MH');
is(phone2country('+7123'), 'RU', '+7 is RU');
is(phone2country('+76123'), 'KZ', '+76 is KZ');
is(phone2country('+77123'), 'KZ', '+77 is KZ');
is(phone2country('+800123'), 'InternationalFreephone', '+800 is InternationalFreephone');
is(phone2country('+808123'), 'SharedCostServices', '+808 is SharedCostServices');
is(phone2country('+81123') , 'JP', '+81 is JP');
is(phone2country('+82123') , 'KR', '+82 is KR');
is(phone2country('+84123') , 'VN', '+84 is VN');
is(phone2country('+850123'), 'KP', '+850 is KP');
is(phone2country('+852123'), 'HK', '+852 is HK');
is(phone2country('+853123'), 'MO', '+853 is MO');
is(phone2country('+855123'), 'KH', '+855 is KH');
is(phone2country('+856123'), 'LA', '+856 is LA');
is(phone2country('+86123') , 'CN', '+86 is CN');
is(phone2country('+870123'), 'Inmarsat', '+870 is Inmarsat');
is(phone2country('+871123'), 'Inmarsat', '+871 is Inmarsat');
is(phone2country('+872123'), 'Inmarsat', '+872 is Inmarsat');
is(phone2country('+873123'), 'Inmarsat', '+873 is Inmarsat');
is(phone2country('+874123'), 'Inmarsat', '+874 is Inmarsat');
is(phone2country('+878123'), 'UniversalPersonalTelecoms', '+878 is UniversalPersonalTelecoms');
is(phone2country('+880123'), 'BD', '+880 is BD');
is(phone2country('+8816123'), 'Iridium', '+8816 is Iridium');
is(phone2country('+8817123'), 'Iridium', '+8817 is Iridium');
is(phone2country('+8818123'), 'Globalstar', '+8818 is Globalstar');
is(phone2country('+8819123'), 'Globalstar', '+8819 is Globalstar');
is(phone2country('+882123'), 'InternationalNetworks', '+882 is InternationalNetworks');
is(phone2country('+886123'), 'TW', '+886 is TW');
is(phone2country('+90123'), 'TR', '+90 is TR');
is(phone2country('+91123'), 'IN', '+91 is IN');
is(phone2country('+92123'), 'PK', '+92 is PK');
is(phone2country('+93123'), 'AF', '+93 is AF');
is(phone2country('+94123'), 'LK', '+94 is LK');
is(phone2country('+95123'), 'MM', '+95 is MM');
is(phone2country('+960123'), 'MV', '+960 is MV');
is(phone2country('+961123'), 'LB', '+961 is LB');
is(phone2country('+962123'), 'JO', '+962 is JO');
is(phone2country('+963123'), 'SY', '+963 is SY');
is(phone2country('+964123'), 'IQ', '+964 is IQ');
is(phone2country('+965123'), 'KW', '+965 is KW');
is(phone2country('+966123'), 'SA', '+966 is SA');
is(phone2country('+967123'), 'YE', '+967 is YE');
is(phone2country('+968123'), 'OM', '+968 is OM');
is(phone2country('+970123'), 'PS', '+970 is PS');
is(phone2country('+971123'), 'AE', '+971 is AE');
is(phone2country('+972123'), 'IL', '+972 is IL');
is(phone2country('+973123'), 'BH', '+973 is BH');
is(phone2country('+974123'), 'QA', '+974 is QA');
is(phone2country('+975123'), 'BT', '+975 is BT');
is(phone2country('+976123'), 'MN', '+976 is MN');
is(phone2country('+977123'), 'NP', '+977 is NP');
is(phone2country('+979123'), 'InternationalPremiumRate', '+979 is InternationalPremiumRate');
is(phone2country('+98123'), 'IR', '+98 is IR');
is(phone2country('+991123'), 'ITPCS', '+991 is ITPCS');
is(phone2country('+992123'), 'TJ', '+992 is TJ');
is(phone2country('+993123'), 'TM', '+993 is TM');
is(phone2country('+994123'), 'AZ', '+994 is AZ');
is(phone2country('+995123'), 'GE', '+995 is GE');
is(phone2country('+996123'), 'KG', '+996 is KG');
is(phone2country('+998123'), 'UZ', '+998 is UZ');