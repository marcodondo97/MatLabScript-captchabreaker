function [Idigits,StringNs,results] = Resolve(n2)

%check if the the file input user exist
FullFileName = fullfile( "imgs/Captcha"+n2+".png")
%if exist start to resolve the captcha
if isfile(FullFileName)


    OriginalIm= imread("imgs/Captcha"+n2+".png");
    GrayIm=rgb2gray(OriginalIm);
    padvalue =0;

    %First attempt with min ordered filter
    FilterIm = ordfilt2(GrayIm,1,ones(2));
    BinaryIm = imbinarize(FilterIm, 0.45);


    %check if the captcha has been resolved
    ControlOcr=any(regexp( (string(ocr(BinaryIm).Text)),'[0-9]'));


    if (ControlOcr==0)
        %Second attempt with median filter
        FilterIm = medfilt2(GrayIm);
        CutIm = FilterIm(5:40, 30:120, :);
        BinaryIm = imbinarize(CutIm, graythresh(CutIm));
      
   
        padvalue =255;
    end



    %Captcha resolved with first or second attempt adjustment
    %add padding
    padsize = 20;
    BinaryIm = padarray(BinaryIm, padsize, padvalue);
    %BInarize image to RGB
    BinaryIm= im2uint8(cat(3, BinaryIm, BinaryIm, BinaryIm));

    %Evaluate the Captcha's text with OCR
    results = ocr(BinaryIm);
    StringIm= string(ocr(BinaryIm).Text);

    %Adjust the the output filtering the result
    StringNs = strrep(StringIm,'B','8');
    StringNs = strrep(StringNs,'Z','2');
    StringNs = strrep(StringNs,'O','0');
    StringNs=erase(StringNs," ");
    StringNs = regexp(StringNs,'\d*','Match');
    IntIm= str2double(StringNs);

    %Insert the boxes with the characters inside the image
    regularExpr = '\d*';
    bboxes = locateText(results,regularExpr,'UseRegexp',true);
    digits = regexp(results.Text,regularExpr,'match');
    Idigits = insertObjectAnnotation(BinaryIm,'rectangle',bboxes,digits);



    %else output empty and show error
else
    Idigits=[];
    StringNs=[];
    results=[];
end
end
