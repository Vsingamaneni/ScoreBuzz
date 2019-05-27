package com.sports.cricket.service;

import com.sports.cricket.model.*;

import java.util.List;

public interface ScheduleService {

    List<Schedule> findAll(String name);

    List<Schedule> scheduleList();

    List<Schedule> topTenScheduleList();

    Schedule findById(Integer matchNumber, String name);

    List<Prediction> findPredictions(Integer memberId);

    List<Prediction> findTopTenPredictions(Integer memberId);

    boolean savePrediction(Prediction prediction, String name);

    boolean updatePrediction(Prediction prediction, String name);

    Prediction getPrediction(Integer predictionId, Integer matchId, String name);

    Prediction getPrediction(Integer predictionId, String name);

    boolean deletePrediction(Integer predictionId, String name);

    boolean authorizeMember(Integer memberId);

    boolean deactivateMember(Integer memberId);

    List<Prediction> getPredictionsByMatch(Integer matchId, String name);

    List<Prediction> getPredictionsByMatchDay(Integer matchDay);

    boolean updateMatchResult(Schedule schedule, String name);

    Integer totalMatches(Integer matchDay, String name);

    boolean updateMatchDay(Integer matchDay, String name);

    boolean addResult(Result result, String name);

    boolean insertPredictions(List<Standings> standingsList, String name);

    List<Standings> getLeaderBoard(String name);

    List<Settlement> getSettlement();

    List<TrackSettlement> getSettlementsTrack();

    Settlement getSettlement(Integer memberId);

    boolean updateSettlement(List<Settlement> settlementList);

    boolean addSettlement(TrackSettlement trackSettlement);

    List<Schedule> getScheduleByMatchDay(Integer matchDay);

    List<Prediction> getAdminPrediction(Integer memberId, Integer matchDay);

}
