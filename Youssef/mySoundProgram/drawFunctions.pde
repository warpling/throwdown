void DrawWaveForm(AudioSample sample,int position){
  for (int i = 0; i < sample.bufferSize() - 1;  i++)
  {
    line(i, position - sample.left.get(i)*50, i+1, position - sample.left.get(i+1)*10);
  }
}
