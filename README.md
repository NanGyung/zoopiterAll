# zoopiterAll

## 프로젝트

- 프론트 + 백 팀프로젝트 저장소입니다 :)

---

### 진행기록

- 회원가입 : MemberDAOImplTest 오류 -> generated key로 memberId를 가져오지 않고 해결 (필요없음)

  #### 04.03: sql 테이블 생성 및 샘플 데이터 파일 업데이트

  - 동물병원 데이터는 공공데이터 사이트의 csv 파일 데이터입니다.(울산광역시, 부산광역시 만 사용)

  - 해당파일

    1. sql 폴더 -> 테이블 생성.sql
    2. 동물병원 데이터(울산, 부산).sql -> hospital_data 테이블 데이터 insert문

  - 마이페이지 회원정보수정 부분은

    1. 회원정보 수정 : member테이블 update 문 (마이페이지-보호자 정보관리)
    2. 반려동물정보 수정 : pet_info테이블 update 문 (마이페이지-반려동물 정보관리)
    3. 의료수첩 작성 시 반려동물 기본정보 불러오는 부분 : pet_note 테이블 select 문 (pet_info(반려동물 기본정보)와 pet_note(의료수첩) join )  
       [ query문 예시 ]

    - 예) select pet_info.pet_name from pet_info, pet_note where pet_info.user_id = pet_note.user_id;

    \*\* 주의사항 : 테이블 생성.sql 실행 시 병원정보테이블(hospital_info) 샘플데이터 insert 문은  
    동물병원 공공데이터 테이블(hospital_data) 샘플데이터(동물병원데이터(울산,부산).sql)를 먼저 넣고 실행하여야 합니다!

  - 의료 수첩 테이블 작성 날짜, 수정 날짜 추가 (문자열 타입)
