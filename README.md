# zoopiterAll

## 프로젝트

- 프론트 + 백 팀프로젝트 저장소입니다 :)

### 진행기록

- MemberDAOImplTest 오류 뜸 : org.springframework.dao.DataRetrievalFailureException: The generated key type is not supported. Unable to cast [java.lang.String] to [java.lang.Number].
  - MemberDAOImpl 47번째 줄이 문제인듯, 아이디 값 타입, DB 테이블에는 문제없이 insert 됨.
    -> generated key로 memberId를 가져오지 않고 해결 (필요없음)
