package com.shudu;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Wei Hu (J) on 2017/3/13.
 */
public class HengMethod extends AbstractMethod {

    AbstractMethod next = new ZongMethod();

    private final static List<Integer> list19 = new ArrayList<>();

    static {
        for(int i=1;i<=9;i++){
            list19.add(i);
        }
    }

    @Override
    public int method(Map map) {
        int total = 0;

        for (int i = 0; i < map.getMap().length; i++) {
            boolean repeat = false;
            List<Integer> nums = new ArrayList<>();
            for (int j = 0; j < map.getMap()[i].length; j++) {
                if (map.getMap()[i][j] != 0) {
                    nums.add(map.getMap()[i][j]);
                }
            }
            for (int j = 0; j < map.getMap()[i].length; j++) {
                if (map.getMap()[i][j] != 0)
                    continue;
                List<Integer> nums2 = new ArrayList<>();
                nums2.addAll(nums);
                for (int i1 = 0; i1 < map.getMap().length; i1++) {
                    if (map.getMap()[i1][j] == 0)
                        continue;
                    if (!nums2.contains(map.getMap()[i1][j])) {
                        nums2.add(map.getMap()[i1][j]);
                    }
                }
                for(int r = i/3*3;r<=i/3*3+2;r++){
                    for(int c = j/3*3;c<=j/3*3+2;c++){
                        if (map.getMap()[r][c] == 0)
                            continue;
                        if (!nums2.contains(map.getMap()[r][c])) {
                            nums2.add(map.getMap()[r][c]);
                        }
                    }
                }
                List<Integer> sub = list19.stream().filter(a->!nums2.contains(a)).collect(Collectors.toList());
                if(sub.size()<=0)
                    System.out.println("解析错误");
                if(sub.size()==1){
                    map.getMap()[i][j] = sub.get(0);
                    total++;
                    repeat =true;
                }
            }
            if(repeat)
                i--;
        }
        System.out.println(total);

        return total + next(map);
    }

    @Override
    public int next(Map map) {
        if(this.next!=null)
            return this.next.method(map);
        return 0;
    }
}
