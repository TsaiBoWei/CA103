package com.example.user.ex3_2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.RotateAnimation;
import android.view.animation.TranslateAnimation;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {


    private Button start, stop;
    private TextView tvMan;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        findViews();
    }

    public void findViews(){
        start = findViewById(R.id.btnStart);
        stop = findViewById(R.id.btnStop);
        tvMan = findViewById(R.id.tvMan);

        start.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tvMan.startAnimation( getAnimationSet() );
            }
        });

        stop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tvMan.clearAnimation();
            }
        });
    }

    // 直線左上到右下的移動
    private TranslateAnimation getTranslateAnimation(){
        TranslateAnimation translateAnimation;
        // 取得tv的父元件
        View parentView = (View)tvMan.getParent();
        // X軸與Y軸的移動距離, 為總寬 - 元件本身寬 - 左右邊界, 高度同理
        float distantceX = parentView.getWidth() - tvMan.getWidth()
                - parentView.getPaddingLeft() - parentView.getPaddingRight();
        float distanceY = parentView.getHeight() - tvMan.getHeight()
                - parentView.getPaddingTop() - parentView.getPaddingBottom();

        translateAnimation = new TranslateAnimation(0, distantceX, 0, distanceY);
        // 動畫總費時
        translateAnimation.setDuration(2500);
        // 動畫是否重複撥放
        translateAnimation.setRepeatMode(Animation.RESTART);
        // 動畫重播次數
        translateAnimation.setRepeatCount(Animation.INFINITE);
        return translateAnimation;
    }

    private RotateAnimation getRotateAnimation(){
        // pivot 物件旋轉的中心點,x: 0為最左, 1為最右 0.5 = 50%
        // y: 0為最上, 1為最下 0.5 = 50% = 置中
        RotateAnimation rotateAnimation = new RotateAnimation(
                0,360,
                Animation.RELATIVE_TO_SELF,0.5f,
                Animation.RELATIVE_TO_SELF,0.5f
        );
        rotateAnimation.setDuration(300);
        rotateAnimation.setRepeatMode(Animation.RESTART);
        rotateAnimation.setRepeatCount(Animation.INFINITE);
        return rotateAnimation;
    }

    private AnimationSet getAnimationSet(){
        AnimationSet animationSet = new AnimationSet(true);
        TranslateAnimation ts = getTranslateAnimation();
        RotateAnimation ro = getRotateAnimation();

        // 注意: 加入的先後順序會影響作用
        // 先加入旋轉效果, 再進行直線移動才會正常運作
        animationSet.addAnimation(ro);
        animationSet.addAnimation(ts);
        return animationSet;
    }
}
