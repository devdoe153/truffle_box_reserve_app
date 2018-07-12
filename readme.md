# 발표 자료
[발표 자료 보기](https://docs.google.com/presentation/d/13yYHA_mvW8gjZxun7_f_gAqL6VB6cQj9lCJAasN_PVY/edit?usp=sharing)

# 시연 시나리오

### 컨트랙트 배포
1. TemaToken
2. TemaTokenMarket
3. Reservation

### TemaToken 발행 (평판 작성 보상풀)
1. TemaToken Owner -> Reservation, 1000000000000000000
2. balanceOf로 토큰 확인

### TemeToken Owner 이전
1. TemaTokenMarket에게 이전 (fallback, buyToken 시 mint를 호출할 수 있도록)
2. owner 확인

### 방 등록 (호스트)
1. 등록 registRoom "드림플러스B1",100
2. 확인 rooms

### 토큰 구매 (게스트)
1. 구매 fallback, 1000 wei
2. 잔액 확인 balanceOf

### 방 예약 (게스트)
1. 예약 reserve "20180707",2
2. 확인 reserves
3. approve 예약자 -> Reservation 컨트랙트 200 (100 * 2박)
3. approve 확인 allowance

### 체크 아웃 (게스트)
1. checkout "GOOD",0
2. getHostReputation

### 돈 받기 (호스트)
1. claim "BADDDD",4
2. getGuestReputation
