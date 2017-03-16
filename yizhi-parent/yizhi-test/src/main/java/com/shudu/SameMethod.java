package com.shudu;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Wei Hu (J) on 2017/3/13.
 */
public class SameMethod extends AbstractMethod {

    AbstractMethod next = new HengMethod();

    @Override
    public int method(Map map) {
        int total = 0;

        for (int i = 1; i <= 9; i++) {
            List<Num> nums = getNumXY(i, map);
            boolean[][] map2 = new boolean[3][3];
            for (int j = 1; j <= 7; j += 3) {
                for (int k = 1; k <= 7; k += 3) {
                    final int row = j;
                    final int col = k;
                    if (nums.stream().anyMatch(a -> a.getX() >= col && a.getX() <= col + 2 && a.getY() >= row && a.getY() <= row + 2)) {
                        map2[j / 3][k / 3] = true;
                    }
                }
            }
            for (int j = 0; j < map2.length; j++) {
                for (int k = 0; k < map2[j].length; k++) {
                    if (map2[j][k] == false) {
                        int col = k * 3 + 1;
                        int row = j * 3 + 1;
                        int count = 0;
                        int x = 0;
                        int y = 0;
                        for (int i1 = row - 1; i1 <= row + 1; i1++) {
                            for (int j1 = col - 1; j1 <= col + 1; j1++) {
                                if (map.getMap()[i1][j1] != 0)
                                    continue;
                                final int fCol = j1 + 1;
                                if (nums.stream().map(a -> a.getX()).anyMatch(a -> a == fCol))
                                    continue;
                                final int fRow = i1 + 1;
                                if (nums.stream().map(a -> a.getY()).anyMatch(a -> a == fRow))
                                    continue;
                                count++;
                                x = i1;
                                y = j1;
                            }
                        }
                        if (count == 1) {
                            map.getMap()[x][y] = i;
                            total++;
                        }
                    }
                }
            }
        }

        System.out.println(total);
        if (total + next(map, this.next) == 0)
            return 0;
        else
            return method(map);
    }

    private List<Num> getNumXY(int num, Map map) {
        List<Num> nums = new ArrayList<>();

        for (int i = 0; i < map.getMap().length; i++) {
            for (int j = 0; j < map.getMap()[i].length; j++) {
                if (map.getMap()[i][j] == num) {
                    Num n = new Num();
                    n.setNum(num);
                    n.setX(j + 1);
                    n.setY(i + 1);
                    nums.add(n);
                }
            }
        }

        return nums;
    }
}
