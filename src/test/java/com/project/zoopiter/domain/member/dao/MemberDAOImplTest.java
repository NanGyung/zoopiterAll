package com.project.zoopiter.domain.member.dao;

import com.project.zoopiter.domain.entity.Member;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberDAOImplTest {

  @Autowired
  private MemberDAO memberDAO;

  @Test
  @DisplayName("가입")
  void save(){
    Member member = new Member();

    member.setUserId("test2");
    member.setUserPw("test1234");
    member.setUserEmail("test2@gmail.com");
    member.setUserNick("별칭2");
    member.setGubun("M0101");

    Member savedMember = memberDAO.save(member);

    Assertions.assertThat(savedMember.getUserId()).isEqualTo("test2");
    Assertions.assertThat(savedMember.getUserPw()).isEqualTo("test1234");
    Assertions.assertThat(savedMember.getUserEmail()).isEqualTo("test2@gmail.com");
    Assertions.assertThat(savedMember.getUserNick()).isEqualTo("별칭2");
    Assertions.assertThat(savedMember.getGubun()).isEqualTo("M0101");

  }

  @Test
  @DisplayName("수정")
  void update(){
    String userId = "test1";
    Member member = new Member();

    member.setUserEmail("u_test1@gmail.com");
    member.setUserPw("utest1234");
    member.setUserNick("별칭1_수정");

    memberDAO.update(userId, member);


  }
}
