#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Encode;

#open OUT, ">:encoding(UTF-8)", "out.txt" or die "$!\n";

my @allowed_word_set = qw/가 각 간 갈 감 갑 강 개 객 갱 거 건 걸 검 게 격 견 결 겸 경 계 고 곡 곤 골 공 과 곽 관 괄 광 괘 괴 굉 교 구 국 군 굴 궁 권 궐 궤 귀 규 균 극 근 금 급 긍 기 긴 길 나 낙 난 날 남 납 낭 내 녀 년 념 녕 노 농 뉴 능 니 다 단 달 담 답 당 대 덕 도 독 돈 돌 동 두 둔 득 등 라 락 란 람 랑 래 랭 략 량 려 력 련 렬 렴 렵 령 례 로 록 론 롱 뢰 료 룡 루 류 륙 륜 률 륭 름 릉 리 린 림 립 마 막 만 말 망 매 맥 맹 면 명 모 목 몽 묘 무 묵 문 물 미 민 밀 박 반 발 방 배 백 번 벌 범 법 벽 변 별 병 보 복 본 봉 부 북 분 불 붕 비 빈 빙 사 삭 산 살 삼 삽 상 쌍 새 색 생 서 석 선 설 섬 섭 성 세 소 속 손 솔 송 쇠 수 숙 순 술 숭 슬 습 승 시 씨 식 신 실 심 십 아 악 안 알 암 압 앙 애 액 앵 야 약 양 어 억 언 엄 업 여 역 연 열 염 엽 영 예 오 옥 온 옹 와 완 왈 왕 외 요 욕 용 우 욱 운 울 웅 원 월 위 유 육 윤 융 은 을 음 읍 응 의 이 익 인 일 임 입 잉 자 작 잠 잡 장 재 쟁 저 적 전 절 점 접 정 제 조 족 존 졸 종 좌 주 죽 준 줄 중 즐 즙 증 지 직 진 질 집 징 차 찬 찰 참 창 채 책 처 척 천 철 첨 첩 청 체 초 촉 촌 총 최 추 축 춘 출 충 취 측 치 칙 친 칠 침 칭 쾌 타 탁 탄 탐 탑 태 택 토 통 퇴 투 특 파 판 팔 패 팽 편 평 폐 포 폭 표 품 풍 필 하 학 한 할 함 합 항 해 핵 행 향 허 헌 험 혁 현 협 형 혜 호 혼 홍 화 확 환 활 황 회 획 횡 효 후 훈 훤 휘 휴 흑 흔 흘 흠 흡 흥 희/;
my @unused_word_set = qw/갈 개 갠 갤 갬 갭 갱 갸 갹 갼 걀 걈 걉 걍 걔 걕 걘 걜 걤 걥 걩 거 걱 걸 겅 게 겍 겐 겔 겜 겝 겡 겨 격 견 결 곅 곈 곌 곔 곕 곙 괍 괼 굄 굅 굑 굔 굘 굠 굡 굥 굼 굽 궘 궙 궝 귁 귄 귈 귐 귑 귕 귤 귬 귭 귱 그 긔 긕 긘 긜 긤 긥 긩 냐 냑 냔 냘 냠 냡 냥 냬 냭 냰 냴 냼 냽 넁 너 넉 넌 널 넘 넙 넝 넥 넨 넨 넬 넴 넵 넹 녁 년 녈 념 녑 녕 녜 녝 녠 녤 녬 녭 녱 놉 놔 놕 놘 놜 놤 놥 놩 뇍 뇐 뇔 뇜 뇝 뇡 뇨 뇩 뇬 뇰 뇸 뇹 뇽 눅 눈 눌 눔 눕 눙 눠 눡 눤 눨 눰 눱 눵 뉘 뉙 뉜 뉠 뉨 뉩 뉭 뉴 뉵 뉸 뉼 늄 늅 늉 느 늑 는 늘 늠 늡 늭 늰 늴 늼 늽 닁 닉 닌 닐 님 닙 닝 e혝 혠 혤 혬 혭 혱 홈 홉 홤 홥 횐 횔 횜 횝 횩 횬 횰 횸 횹 횽 훅 훌 훔 훕 훙 훨 훰 훱 훵 휙 휜 휠 휨 휩 휭 휵 휸 휼 흄 흅 흉 흐 흘 흠 흡 흭 흰 흴 흼 흽 힁 히 힉 힌 힙 힝/;

# %cho, %jun, %jon 은 초성, 중성, 종성의 순서를 나타냅니다.
# print "$_ : ".chr($_)."\n" foreach keys %cho;
# 같은 코드를 이용하면 확인해보실 수 있습니다.

# wide character 어쩌구 오류메세지를 막기 위해 인코딩을 사용했습니다.
binmode STDOUT, ':utf8';

# 초성 해시 테이블
my %cho = (
	0x3131 => 0 ,	# ㄱ
	0x3132 => 1 ,	# ㄲ
#	0x3133 => 2 ,	# ㄱ+ㅅ
	0x3134 => 2 ,	# ㄴ
#	0x3135 => 4 ,	# ㄴ+ㅈ
#	0x3136 => 5 ,	# ㄴ+ㅎ
	0x3137 => 3 ,	# ㄷ
	0x3138 => 4 ,	# ㄸ
	0x3139 => 5 ,	# ㄹ 
#	0x313A => 9 ,	# ㄹ+ㄱ 
#	0x313B => 10 ,	# ㄹ+ㅁ
#	0x313C => 11 ,	# ㄹ+ㅂ
#	0x313D => 12 ,	# ㄹ+ㅅ
#	0x313E => 13 ,	# ㄹ+ㅌ
#	0x313F => 14 ,	# ㄹ+ㅍ
#	0x3140 => 15 ,	# ㄹ+ㅎ
	0x3141 => 6 ,	# ㅁ
	0x3142 => 7 ,	# ㅂ
	0x3143 => 8 ,	# ㅃ
#	0x3144 => 19 ,	# ㅂ+ㅅ
	0x3145 => 9 ,	# ㅅ
	0x3146 => 10 ,	# ㅆ
	0x3147 => 11 ,	# ㅇ
	0x3148 => 12 ,	# ㅈ
	0x3149 => 13 ,	# ㅉ
	0x314A => 14 ,	# ㅊ
	0x314B => 15 ,	# ㅋ
	0x314C => 16 ,	# ㅌ
	0x314D => 17 ,	# ㅍ
	0x314E => 18 ,	# ㅎ
);
#print "$_ : ".chr($_)."\n" foreach keys %cho;

# 중성 해시 테이블
my %jun = (
	0x314F => 0,	# ㅏ
	0x3150 => 1,	# ㅐ
	0x3151 => 2,	# ㅑ
	0x3152 => 3,	# ㅒ
	0x3153 => 4,	# ㅓ
	0x3154 => 5,	# ㅔ
	0x3155 => 6,	# ㅕ
	0x3156 => 7,	# ㅖ
	0x3157 => 8,	# ㅗ
	0x3158 => 9,	# ㅘ
	0x3159 => 10,	# ㅙ
	0x315A => 11,	# ㅚ
	0x315B => 12,	# ㅛ
	0x315C => 13,	# ㅜ
	0x315D => 14,	# ㅝ
	0x315E => 15,	# ㅞ
	0x315F => 16,	# ㅟ
	0x3160 => 17,	# ㅠ
	0x3161 => 18,	# ㅡ
	0x3162 => 19,	# ㅢ
	0x3163 => 20,	# ㅣ
);
#print "$_ : ".chr($_)."\n" foreach keys %jun;

# 종성 해시 테이블
my %jon = (
	0x0000 => 0 ,	# 종성 안쓰일 때
	0x3131 => 1 ,	# ㄱ
	0x3132 => 2 ,	# ㄲ
	0x3133 => 3 ,	# ㄱ+ㅅ
	0x3134 => 4 ,	# ㄴ
	0x3135 => 5 ,	# ㄴ+ㅈ
	0x3136 => 6 ,	# ㄴ+ㅎ
	0x3137 => 7 ,	# ㄷ
#	0x3138 => 7 ,	# ㄸ
	0x3139 => 8 ,	# ㄹ 
	0x313A => 9 ,	# ㄹ+ㄱ 
	0x313B => 10 ,	# ㄹ+ㅁ
	0x313C => 11 ,	# ㄹ+ㅂ
	0x313D => 12 ,	# ㄹ+ㅅ
	0x313E => 13 ,	# ㄹ+ㅌ
	0x313F => 14 ,	# ㄹ+ㅍ
	0x3140 => 15 ,	# ㄹ+ㅎ
	0x3141 => 16 ,	# ㅁ
	0x3142 => 17 ,	# ㅂ
#	0x3143 => 18 ,	# ㅃ
	0x3144 => 18 ,	# ㅂ+ㅅ
	0x3145 => 19 ,	# ㅅ
	0x3146 => 20 ,	# ㅆ
	0x3147 => 21 ,	# ㅇ
	0x3148 => 22 ,	# ㅈ
#	0x3149 => 24 ,	# ㅉ
	0x314A => 23 ,	# ㅊ
	0x314B => 24 ,	# ㅋ
	0x314C => 25 ,	# ㅌ
	0x314D => 26 ,	# ㅍ
	0x314E => 27 ,	# ㅎ
);
#print "$_ : ".chr($_)."\n" foreach keys %jon;

my @numset;
#map { push @numset, ord $_ foreach (split //, $_) } @allowed_word_set;
# @ARGV에서 받은 한글을 split 하니까 오류가 나서 포기했습니다.

map { push @numset, ord $_ } @allowed_word_set; # 한글 문자열을 유니코드 문자세트로 바꿉니다.

my @filter;
my $idx=0;

# 문자세트를 한 글자마다 분리시키기 위해 루프를 돌립니다.
# @$numset[0]은 초성, [1]에는 중성, [2]에는 종성을 넣도록 합니다.
while (@numset) { 
	my $qq = shift @numset;
	if ( $qq > 0x3163 || $qq < 0x3131 ) { # 초, 중, 종성의 문자셋이 아니면 한 글자로 집어넣습니다.
		push @{$filter[$idx]}, $qq;
		$idx++;
		next; # 지금 것은 처리가 끝났으니 다음 문자로 갑시다.
	}
	if (($qq <= 0x314E && $numset[0] > 0x314E ) ||
		( ${$filter[$idx]}[2] )) {
			$idx++; # 지금 글자에 종성까지 들어가 있거나
# 다음 문자가 모음이라면 다음 글자로 가서
	}
	push @{$filter[$idx]}, $qq; # 집어 넣습니다.
}

foreach ( @filter ) {
	($_=$$_[0])&&(next) unless $$_[1]; # 중성도 없다면 $_ 를 그 배열(@$_)의 첫번째 값으로 바꿉니다.
	$$_[2] = $$_[2] || "0"; # null 대신 0을 넣어줍니다.
# 안 해주면, 종성이 없을 때에는 경고메세지를 출력합니다.
	$_ = ($cho{$$_[0]}*0x15 + $jun{$$_[1]})*0x1C + $jon{$$_[2] } + 0xAC00; # $_에 배열 대신 계산값 대입.
}
print "Filter List\n";
print chr($_) foreach @filter;
print "\n";

#my @nani;
#$nani[0] = ($cho{0x3145}*0x15 + $jun{0x3163})*0x1C + $jon{0x3134} + 0xAC00; # ㅅ ㅣ ㄴ
#$nani[1] = ($cho{0x314C}*0x15 + $jun{0x3150})*0x1C + $jon{0x3131} + 0xAC00; # ㅌ ㅐ ㄱ
#$nani[2] = ($cho{0x3145}*0x15 + $jun{0x315C})*0x1C + $jon{0x0000} + 0xAC00; # ㅅ ㅜ
#print chr($_) foreach @nani;
#print "\n";

my @choseong;
$choseong[0] = 0x3131; 		# ㄱ
$choseong[1] = 0x3134; 		# ㄴ
$choseong[2] = 0x3137; 		# ㄷ
$choseong[3] = 0x3139; 		# ㄹ
#$choseong[4] = 0x3141; 		# ㅁ
#$choseong[5] = 0x3142; 		# ㅂ
#$choseong[6] = 0x3145; 		# ㅅ
$choseong[4] = 0x3147;		# ㅇ
#$choseong[8] = 0x3148;	 	# ㅈ
#$choseong[9] = 0x314A;	 	# ㅊ
$choseong[5] = 0x314B; 	# ㅋ
$choseong[6] = 0x314C; 	# ㅌ
#$choseong[12] = 0x314D; 	# ㅍ
$choseong[7] = 0x314E; 	# ㅎ

my @jungseong;
$jungseong[0] = 0x314F;		# ㅏ
$jungseong[1] = 0x3150;		# ㅐ
$jungseong[2] = 0x3151;		# ㅑ
$jungseong[3] = 0x3152;		# ㅒ
$jungseong[4] = 0x3153;		# ㅓ
$jungseong[5] = 0x3154;		# ㅔ
$jungseong[6] = 0x3155;		# ㅕ
$jungseong[7] = 0x3156;		# ㅖ
$jungseong[8] = 0x3157;		# ㅗ
$jungseong[9] = 0x3158;		# ㅘ
#$jungseong[10] = 0x3159;	# ㅙ
$jungseong[10] = 0x315A;	# ㅚ
$jungseong[11] = 0x315B;	# ㅛ
$jungseong[12] = 0x315C;	# ㅜ
$jungseong[13] = 0x315D;	# ㅝ
#$jungseong[15] = 0x315E;	# ㅞ
$jungseong[14] = 0x315F;	# ㅟ
$jungseong[15] = 0x3160;	# ㅠ
$jungseong[16] = 0x3161;	# ㅡ
$jungseong[17] = 0x3162;	# ㅢ
$jungseong[18] = 0x3163;	# ㅣ

my @jongseong;
$jongseong[0] = 0x0000;		# 종성 안쓰일 때
$jongseong[1] = 0x3131;		# ㄱ
$jongseong[2] = 0x3134;		# ㄴ
#$jongseong[3] = 0x3137;		# ㄷ
$jongseong[3] = 0x3139;		# ㄹ 
$jongseong[4] = 0x3141;		# ㅁ
$jongseong[5] = 0x3142;		# ㅂ
#$jongseong[7] = 0x3145;		# ㅅ
$jongseong[6] = 0x3147;		# ㅇ
#$jongseong[9] = 0x3148;		# ㅈ
#$jongseong[10] = 0x314A;	# ㅊ
#$jongseong[11] = 0x314B;	# ㅋ
#$jongseong[12] = 0x314C;	# ㅌ
#$jongseong[13] = 0x314D;	# ㅍ
#$jongseong[14] = 0x314E;	# ㅎ

my @shininahyo;
my $x;
my $y;
my $z;
my $a;
my $b;
my $c;
my $allowed_word;
$shininahyo[0] = ($cho{0x3145}*0x15 + $jun{0x3163})*0x1C + $jon{0x3134} + 0xAC00; # ㅅ ㅣ ㄴ
foreach $x(0..7) {
	foreach $y(0..18) {
		foreach $z(0..6) {
			$shininahyo[1] = ($cho{$choseong[$x]}*0x15 + $jun{$jungseong[$y]})*0x1C + $jon{$jongseong[$z]} + 0xAC00;
			foreach $allowed_word(@filter) {
				if ($shininahyo[1] eq $allowed_word) {
					foreach $a(0..7) {
						foreach $b(0..18) {
							foreach $c(0..6) {
								$shininahyo[2] = ($cho{$choseong[$a]}*0x15 + $jun{$jungseong[$b]})*0x1C + $jon{$jongseong[$c]} + 0xAC00;
								foreach $allowed_word(@filter) {
									if ($shininahyo[2] eq $allowed_word) {
										print chr($_) foreach @shininahyo;
										print " ";
										last;
									}
								}
							}
						}
						print "\n";
					}
					last;
				}
			}
		}
	}
	print "\n";
}

