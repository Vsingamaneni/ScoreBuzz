package com.sports.cricket.config;

import javax.sql.DataSource;

import com.sports.cricket.dao.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.Properties;

@Configuration
public class SpringJDBCConfiguration implements Serializable {
    /*@Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        //MySQL database we are using
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        //Google cloud URL - 104.198.192.106
        //dataSource.setUrl("jdbc:mysql://35.237.53.198:3306/ipl");

        // Local
        dataSource.setUrl("jdbc:mysql://localhost:3306/worldcup");
        dataSource.setUsername("root");
        dataSource.setPassword("");

        return dataSource;
    }*/

    // Google Cloud connection
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        String url = null;

        Properties properties = new Properties();

        try {
            String propFileName = "config.properties";
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
            properties.load(inputStream);
            url = properties.getProperty("sqlUrl");
        } catch (IOException e) {
            System.out.println("Failed to read properties");
        }

        dataSource.setUrl(url);

        //dataSource.setUrl(System.getProperty("auto"));
        return dataSource;
    }

    @Bean
    public JdbcTemplate jdbcTemplate() {
        JdbcTemplate jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource());
        return jdbcTemplate;
    }

    @Bean
    public UserDao userDao(){
        UserDaoImpl userDao = new UserDaoImpl();
        userDao.setJdbcTemplate(jdbcTemplate());
        userDao.setDataSource(dataSource());
        return userDao;
    }

    @Bean
    public ScheduleDao scheduleDao(){
        ScheduleDaoImpl scheduleDao = new ScheduleDaoImpl();
        scheduleDao.setDataSource(dataSource());
        scheduleDao.setJdbcTemplate(jdbcTemplate());
        return scheduleDao;
    }

    @Bean
    public RegistrationDao registrationDao(){
        RegistrationDaoImpl registrationDao = new RegistrationDaoImpl();
        registrationDao.setDataSource(dataSource());
        registrationDao.setJdbcTemplate(jdbcTemplate());
        return registrationDao;
    }


}