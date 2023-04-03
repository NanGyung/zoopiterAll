# zoopiterAll

## 프로젝트

- 프론트 + 백 팀프로젝트 저장소입니다 :)

### 진행기록

- 회원가입 : MemberDAOImplTest 오류 -> generated key로 memberId를 가져오지 않고 해결 (필요없음)

- 04.03: sql 테이블 생성 및 샘플 데이터 파일 업데이트
  - 동물병원 데이터는 공공데이터 사이트의 csv 파일 데이터입니다.(울산광역시, 부산광역시 만 사용)
  - 해당파일 : sql 폴더 -> 테이블 생성.sql, 동물병원 데이터(울산, 부산).sql -> 데이터 insert문
  - 마이페이지 회원정보수정 부분은
    1. 회원정보 수정 : member테이블 update 문 (마이페이지-보호자 정보관리)
    2. 반려동물정보 수정 : pet_info테이블 update 문 (마이페이지-반려동물 정보관리)
    3. 의료수첩 작성 시 반려동물 기본정보 불러오는 부분 : pet_note 테이블 select 문 (pet_info(반려동물 기본정보)와 pet_note(의료수첩) join )
    - 예) select pet_info.pet_name from pet_info, pet_note where pet_info.user_id = pet_note.user_id;
