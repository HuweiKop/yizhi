package com.shudu;

/**
 * Created by Wei Hu (J) on 2017/3/13.
 */
public class Map {
    private int[][] map = new int[9][9];

    public void init(){
        map = new int[][]{{5, 0, 9, 0, 0, 4, 0, 1, 0},
                        {6, 0, 0, 8, 0, 2, 0, 0, 5},
                        {0, 4, 0, 3, 0, 0, 6, 0, 7},
                        {0, 0, 4, 0, 0, 7, 9, 0, 0},
                        {0, 6, 0, 9, 2, 0, 0, 3, 0},
                        {9, 0, 0, 0, 4, 0, 0, 7, 0},
                        {0, 5, 0, 0, 1, 0, 0, 0, 3},
                        {0, 9, 0, 0, 8, 5, 0, 2, 0},
                        {0, 0, 1, 2, 0, 0, 4, 0, 0}};
    }

    public void printMap(){
        System.out.println("map=================");
        for(int i=0;i<this.map.length;i++){
            for(int j=0;j<this.map[i].length;j++){
                System.out.print(map[i][j]+" ");
            }
            System.out.println();
        }
        System.out.println("map=================");
    }

    public int[][] getMap() {
        return map;
    }
}
