package com.sports.cricket.service;

import com.sports.cricket.dao.ScheduleDao;
import com.sports.cricket.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService, Serializable {

    ScheduleDao scheduleDao;

    @Autowired
    public void setScheduleDao(ScheduleDao scheduleDao) {
        this.scheduleDao = scheduleDao;
    }

    @Override
    public List<Schedule> findAll(String name) {
        return scheduleDao.findAll(name);
    }

    @Override
    public List<Schedule> scheduleList() {
        return scheduleDao.scheduleList();
    }

    @Override
    public List<Schedule> topTenScheduleList() {
        return scheduleDao.topTenScheduleList();
    }

    @Override
    public Schedule findById(Integer matchNumber,  String name) {
        return scheduleDao.findById(matchNumber, name);
    }

    @Override
    public List<Prediction> findPredictions(Integer memberId) {
        return scheduleDao.findPredictions(memberId);
    }

    @Override
    public List<Prediction> findTopTenPredictions(Integer memberId) {
        return scheduleDao.findTopTenPredictions(memberId);
    }

    @Override
    public boolean savePrediction(Prediction prediction, String name) {
        return scheduleDao.savePrediction(prediction, name);
    }

    @Override
    public boolean updatePrediction(Prediction prediction, String name) {
        return scheduleDao.updatePrediction(prediction, name);
    }

    @Override
    public Prediction getPrediction(Integer predictionId, Integer matchId, String name) {
        return scheduleDao.getPrediction(predictionId, matchId, name);
    }

    @Override
    public Prediction getPrediction(Integer predictionId, String name) {
        return scheduleDao.getPrediction(predictionId, name);
    }

    @Override
    public boolean deletePrediction(Integer predictionId, String name) {
        return scheduleDao.deletePrediction(predictionId, name);
    }

    @Override
    public boolean authorizeMember(Integer memberId) {
        return scheduleDao.authorizeMember(memberId);
    }

    @Override
    public boolean deactivateMember(Integer memberId) {
        return scheduleDao.deactivateMember(memberId);
    }

    @Override
    public List<Prediction> getPredictionsByMatch(Integer matchId, String name) {
        return scheduleDao.getPredictionsByMatch(matchId, name);
    }

    @Override
    public List<Prediction> getPredictionsByMatchDay(Integer matchDay) {
        return scheduleDao.getPredictionByMatchDay(matchDay);
    }


    @Override
    public boolean updateMatchResult(Schedule schedule, String name) {
        return scheduleDao.updateMatchResult(schedule, name);
    }

    @Override
    public Integer totalMatches(Integer matchDay, String name) {
        return scheduleDao.totalMatches(matchDay, name);
    }

    @Override
    public boolean updateMatchDay(Integer matchDay, String name) {
        return scheduleDao.updateMatchDay(matchDay, name);
    }

    @Override
    public boolean addResult(Result result, String name) {
        return scheduleDao.addResult(result, name);
    }

    @Override
    public boolean insertPredictions(List<Standings> standingsList, String name) {
       return scheduleDao.insertPredictions(standingsList, name);
    }

    @Override
    public List<Standings> getLeaderBoard(String name) {
        return scheduleDao.getLeaderBoard(name);
    }

    @Override
    public List<Settlement> getSettlement() {
        return scheduleDao.getSettlement();
    }

    @Override
    public List<TrackSettlement> getSettlementsTrack() {
        return scheduleDao.getSettlementsTrack();
    }

    @Override
    public Settlement getSettlement(Integer memberId) {
        return scheduleDao.getSettlement(memberId);
    }

    @Override
    public boolean updateSettlement(List<Settlement> settlementList) {
        return scheduleDao.updateSettlement(settlementList);
    }

    @Override
    public boolean addSettlement(TrackSettlement trackSettlement) {
        return scheduleDao.addSettlement(trackSettlement);
    }

    @Override
    public List<Schedule> getScheduleByMatchDay(Integer matchDay) {
        return scheduleDao.getScheduleByMatchDay(matchDay);
    }

    @Override
    public List<Prediction> getAdminPrediction(Integer memberId, Integer matchDay) {
        return scheduleDao.getAdminPrediction(memberId, matchDay);
    }

}
