package com.sports.cricket.util;

import com.sports.cricket.model.*;
import org.springframework.util.CollectionUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import static java.util.Comparator.nullsLast;
import static java.util.Comparator.reverseOrder;

public class LeaderBoardDetails implements Serializable {

    public static List<LeaderBoard> mapLeaderBoard(List<Standings> standingsList , List<Register> registerList){

        List<LeaderBoard> leaderBoardList = new ArrayList<>();

        LeaderBoard leaderBoard;

        for(Register register : registerList){
            leaderBoard = new LeaderBoard();
            leaderBoard.setMemberId(register.getMemberId());
            leaderBoard.setFirstName(register.getfName());
            leaderBoard.setLastName(register.getlName());
            leaderBoard.setWonAmount(Float.valueOf("0"));
            leaderBoard.setLostAmount(Float.valueOf("0"));
            for(Standings standings : standingsList){
                if(standings.getMemberId() == register.getMemberId()){
                    leaderBoard.setWonAmount(Float.valueOf(String.format("%.2f",leaderBoard.getWonAmount() + standings.getWonAmount())));
                    leaderBoard.setLostAmount(Float.valueOf(String.format("%.2f",leaderBoard.getLostAmount() + standings.getLostAmount())));
                }
            }
            leaderBoard.setTotal(Float.valueOf(String.format("%.2f",leaderBoard.getWonAmount() - leaderBoard.getLostAmount())));
            leaderBoard.setIsActive(register.getIsActive());
            leaderBoardList.add(leaderBoard);
        }

        Collections.sort(leaderBoardList, new LeaderBoardComp());

        int count = 1;

        for(LeaderBoard leader : leaderBoardList){
            leader.setRank(count);
            count++;
        }
        return leaderBoardList;
    }

    public static List<Standings> getStandings(List<Standings> standingsList, Integer memberId){

        List<Standings> userStandingsList = new ArrayList<>(standingsList);

        for(Standings standings : standingsList){
            if(standings.getMemberId() != memberId ){
                userStandingsList.remove(standings);
            }
        }

        return userStandingsList;
    }

    public static boolean isLimitReached(List<Standings> standingsList, Integer memberId, Integer maxLimit){

        double netAmount = 0;
        double maxLimitValue = (double)maxLimit;

        for(Standings standings : standingsList){
            if(standings.getMemberId() == memberId)
            {
                netAmount = netAmount - standings.getLostAmount() + standings.getWonAmount();
            }
        }

        if(netAmount <(Math.abs(maxLimitValue) * -1 )){
            return true;
        }

        return false;
    }

    public static void sortSettlement(List<Settlement> settlementList){
        Collections.sort(settlementList, new SettlementComp());
    }

    static class LeaderBoardComp implements Comparator<LeaderBoard> {

        @Override
        public int compare(LeaderBoard l1, LeaderBoard l2) {
            if(l1.getTotal() < l2.getTotal()){
                return 1;
            } else {
                return -1;
            }
        }
    }

    static class SettlementComp implements Comparator<Settlement> {

        @Override
        public int compare(Settlement l1, Settlement l2) {
            if(l1.getNet() < l2.getNet()){
                return 1;
            } else {
                return -1;
            }
        }
    }


    public static LeaderBoard getCurrentUserStandings(List<LeaderBoard> leaderBoardList, Integer memberId){
        if (!CollectionUtils.isEmpty(leaderBoardList)){
            for(LeaderBoard leaderBoard : leaderBoardList){
                if (leaderBoard.getMemberId() == memberId){
                    return leaderBoard;
                }
            }
        }

        return null;
    }

    public static List<Standings> setResults(List<Standings> standingsList){

        for (Standings standings: standingsList){
            if (standings.getSelected().equalsIgnoreCase(standings.getWinner())){
                standings.setResult("win");
            } else if (!standings.getSelected().equalsIgnoreCase(standings.getWinner())
                    && !standings.getWinner().equalsIgnoreCase("draw")){
                standings.setResult("loss");
            } else if (standings.getWinner().equalsIgnoreCase("draw")){
                standings.setResult("draw");
            }
        }

        return standingsList;
    }

    public static Settlement getMemberSettlement(List<Settlement> settlementList, UserLogin userLogin){
        if (!CollectionUtils.isEmpty(settlementList)){
            for (Settlement settlement : settlementList){
                if (settlement.getMemberId() == userLogin.getMemberId()){
                    return settlement;
                }
            }
        }
        return null;
    }

    public static List<LeaderBoard>  mapTopTenLeaderBoard(List<Standings> standingsList, List<Register> registerList, Restrictions restrictions) {
        List<LeaderBoard> leaderBoardList = new ArrayList<>();
        LeaderBoard leaderBoard;
        if (!CollectionUtils.isEmpty(standingsList)) {
            for (Register register : registerList) {
                leaderBoard = new LeaderBoard();
                leaderBoard.setMemberId(register.getMemberId());
                leaderBoard.setFirstName(register.getfName());
                leaderBoard.setLastName(register.getlName());

                int count = 0;
                int predictedCount = 0;
                for (Standings standings : standingsList) {
                    if (register.getMemberId() != standings.getMemberId()) {
                        continue;
                    }
                    if (standings.getSelected().equalsIgnoreCase(standings.getWinner())
                            && !standings.getWinner().equalsIgnoreCase("draw")){
                        count = count+1;
                        predictedCount = predictedCount + standings.getPredictedCount();
                    }
                }
                leaderBoard.setTotalWins(count);
                leaderBoard.setPredictedCount(predictedCount);
                leaderBoardList.add(leaderBoard);
            }
        }

        Collections.sort(leaderBoardList, Comparator.comparing(LeaderBoard::getTotalWins).reversed()
                .thenComparing(LeaderBoard::getPredictedCount)
                .thenComparing(LeaderBoard::getFirstName));

        int count = 1;

        /*for(LeaderBoard leader : leaderBoardList){
            if (restrictions.getCount() >= count){
                leader.setPrizeMoney(restrictions.getPrize()-500);
            } else {
                leader.setPrizeMoney(0);
            }

            leader.setRank(count);
            count++;
        }*/

       // addWinAmount(leaderBoardList, restrictions);

        mapRank(leaderBoardList);

        return leaderBoardList;
    }

    private static void addWinAmount(List<LeaderBoard> leaderBoardList, Restrictions restrictions){
        if (!CollectionUtils.isEmpty(leaderBoardList)){
            for (LeaderBoard leaderBoard : leaderBoardList){
                if (leaderBoard.getRank() == 1){
                    continue;
                }
                if (leaderBoard.getRank() <= restrictions.getCount()) {
                    leaderBoard.setPrizeMoney(leaderBoard.getPrizeMoney() - ((leaderBoard.getRank() -1) * restrictions.getDifference()));
                }
            }
        }
    }

    public static void mapRank(List<LeaderBoard> leaderBoardList){
        int rank = 1;
        if (!CollectionUtils.isEmpty(leaderBoardList)){
            for (LeaderBoard leaderBoard : leaderBoardList){
                if (leaderBoard.getRank() == null ) {
                    rank = getMembers(leaderBoard.getTotalWins(), leaderBoard.getPredictedCount(), leaderBoardList,rank);
                } else {
                    continue;
                }
            }
        }
    }

    public static int getMembers(int wins, int count, List<LeaderBoard> leaderBoardList, int rank){
        for (LeaderBoard leaderBoard : leaderBoardList){
            if (leaderBoard.getTotalWins() == wins && leaderBoard.getPredictedCount() == count){
                leaderBoard.setRank(rank);
            }
        }
        return rank+1;
    }

}
