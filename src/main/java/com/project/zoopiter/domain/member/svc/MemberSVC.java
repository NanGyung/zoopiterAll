package com.project.zoopiter.domain.member.svc;

import com.project.zoopiter.domain.entity.Member;

import java.util.List;
import java.util.Optional;

public interface MemberSVC {
  /**
   * 가입
   * @param member 회원정보
   * @return
   */
  Member save(Member member);

  /**
   * 회원정보수정
   * @param userId 아이디
   * @param member 회원정보
   */
  void update(String userId, Member member);

  /**
   * 조회 by email
   * @param userEmail 이메일
   * @return
   */
  Optional<Member> findbyEmail(String userEmail);

  /**
   * 조회 by user_id
   * @param userId 아이디
   * @return
   */
  Optional<Member> findById(String userId);

  /**
   * 전체 조회
   * @return
   */
  List<Member> findAll();

  /**
   * 탈퇴
   * @param userId 아이디
   */
  void delete(String userId);

  /**
   * 회원유무
   * @param userEmail 이메일
   * @return
   */
  boolean isExist(String userEmail);

  /**
   * 로그인
   * @param userId 아이디
   * @param userPw 비밀번호
   * @return
   */
  Optional<Member> login(String userId, String userPw);

  /**
   * 아이디 찾기
   * @param userEmail 이메일
   * @return
   */
  Optional<String> findIdByEmail(String userEmail);
}
