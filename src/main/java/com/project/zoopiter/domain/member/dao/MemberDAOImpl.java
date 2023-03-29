package com.project.zoopiter.domain.member.dao;

import com.project.zoopiter.domain.entity.Member;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Slf4j
@Repository
@RequiredArgsConstructor
public class MemberDAOImpl implements MemberDAO {

  private final NamedParameterJdbcTemplate template;

  /**
   * 가입
   * @param member 회원정보
   * @return
   */
  @Override
  public Member save(Member member) {
    StringBuffer sql = new StringBuffer();
    sql.append("insert into member( ");
    sql.append(" USER_ID, ");
    sql.append(" USER_PW, ");
    sql.append(" USER_NICK, ");
    sql.append(" USER_EMAIL, ");
    sql.append("GUBUN) values( ");
    sql.append(" :userId, ");
    sql.append(" :userPw, ");
    sql.append(" :userNick, ");
    sql.append(" :userEmail, ");
    sql.append(" :gubun) ");

    SqlParameterSource param = new BeanPropertySqlParameterSource(member);
    KeyHolder keyHolder = new GeneratedKeyHolder();
    template.update(sql.toString(),param,keyHolder,new String[]{"user_id"});

    String userId = String.valueOf(keyHolder.getKey());

    member.setUserId(userId);
    return member;
  }

  /**
   * 회원정보수정
   *
   * @param userId 아이디
   * @param member 회원정보
   */
  @Override
  public void update(String userId, Member member) {

  }

  /**
   * 조회 by email
   *
   * @param userEmail 이메일
   * @return
   */
  @Override
  public Optional<Member> findbyEmail(String userEmail) {
    return Optional.empty();
  }

  /**
   * 조회 by user_id
   *
   * @param userId 아이디
   * @return
   */
  @Override
  public Optional<Member> findById(String userId) {
    return Optional.empty();
  }

  /**
   * 전체 조회
   *
   * @return
   */
  @Override
  public List<Member> findAll() {
    return null;
  }

  /**
   * 탈퇴
   *
   * @param userId 아이디
   */
  @Override
  public void delete(String userId) {

  }

  /**
   * 회원유무
   *
   * @param userEmail 이메일
   * @return
   */
  @Override
  public boolean isExist(String userEmail) {
    return false;
  }

  /**
   * 로그인
   *
   * @param userId 아이디
   * @param userPw 비밀번호
   * @return
   */
  @Override
  public Optional<Member> login(String userId, String userPw) {
    return Optional.empty();
  }

  /**
   * 아이디 찾기
   *
   * @param userEmail 이메일
   * @return
   */
  @Override
  public Optional<String> findIdByEmail(String userEmail) {
    return Optional.empty();
  }
}