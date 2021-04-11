
package org.qtproject.example.activityhandler;

import android.app.Activity;
//import org.libsdl.app.SDLActivity;
import android.os.Bundle;

import android.widget.EditText;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;

//public class Sdl2Activity extends SDLActivity {
public class Sdl2Activity extends Activity {

@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        EditText editText = new EditText(this);
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(LayoutParams.MATCH_PARENT,
                LayoutParams.WRAP_CONTENT);
        params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
        // use same id as defined when adding the button
        params.addRule(RelativeLayout.LEFT_OF, 1001);
        editText.setLayoutParams(params);
        editText.setHint("Введите имя кота....");

        Button button = new Button(this);
        RelativeLayout.LayoutParams params2 = new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT);
        params2.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        button.setLayoutParams(params2);
        button.setText("Нажми нежно!");
        // give the button an id that we know
        button.setId(1001);
        RelativeLayout layout = new RelativeLayout(this);
        layout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
        layout.addView(editText);
        layout.addView(button);
        setContentView(layout);
        }
}
