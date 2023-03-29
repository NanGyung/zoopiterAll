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
    member.setUserEmail("member22@gmail.com");
    member.setUserId("member2");
    member.setUserPw("member4321");
    member.setUserNick("회원4");
    member.setGubun("M0101");

    Member savedMember = memberDAO.save(member);

    Assertions.assertThat(savedMember.getUserId()).isEqualTo("member1");
    Assertions.assertThat(savedMember.getUserPw()).isEqualTo("member1234");
    Assertions.assertThat(savedMember.getUserEmail()).isEqualTo("member97@gmail.com");
    Assertions.assertThat(savedMember.getUserNick()).isEqualTo("회원3");
    Assertions.assertThat(savedMember.getGubun()).isEqualTo("M0101");


  }
}
