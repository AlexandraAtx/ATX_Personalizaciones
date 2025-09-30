report 50111 "CalcandPostVATSettlement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/VAT/Reporting/CalcandPostVAT.rdl';
    AdditionalSearchTerms = 'settle vat value added tax,report vat value added tax';
    ApplicationArea = Basic, Suite;
    Caption = 'Calcular y contabilizar la liquidación del IVA';
    Permissions = TableData "VAT Entry" = rimd;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("VAT Posting Setup"; "VAT Posting Setup")
        {
            DataItemTableView = sorting("VAT Bus. Posting Group", "VAT Prod. Posting Group");
            RequestFilterFields = "VAT Bus. Posting Group", "VAT Prod. Posting Group";
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(PeriodVATDateFilter; StrSubstNo(Text005, DateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(PostSettlement; PostSettlement)
            {
            }
            column(PostingDate; Format(PostingDate))
            {
            }
            column(VATDate; Format(VATDate))
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(GLAccSettleNo; GLAccSettle."No.")
            {
            }
            column(UseAmtsInAddCurr; UseAmtsInAddCurr)
            {
            }
            column(PrintVATEntries; PrintVATEntries)
            {
            }
            column(VATPostingSetupCaption; TableCaption + ': ' + VATPostingSetupFilter)
            {
            }
            column(VATPostingSetupFilter; VATPostingSetupFilter)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(VATAmount; VATAmount)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(VATAmountAddCurr; VATAmountAddCurr)
            {
                AutoFormatExpression = GetCurrency();
                AutoFormatType = 1;
            }
            column(CalcandPostVATSettlementCaption; CalcandPostVATSettlementCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(TestReportnotpostedCaption; TestReportnotpostedCaptionLbl)
            {
            }
            column(DocNoCaption; DocNoCaptionLbl)
            {
            }
            column(SettlementAccCaption; SettlementAccCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(UserIDCaption; UserIDCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(DocumentNoCaption; "VAT Entry".FieldCaption("Document No."))
            {
            }
            column(TypeCaption; "VAT Entry".FieldCaption(Type))
            {
            }
            column(BaseCaption; "VAT Entry".FieldCaption(Base))
            {
            }
            column(AmountCaption; "VAT Entry".FieldCaption(Amount))
            {
            }
            column(UnrealizedBaseCaption; "VAT Entry".FieldCaption("Unrealized Base"))
            {
            }
            column(UnrealizedAmountCaption; "VAT Entry".FieldCaption("Unrealized Amount"))
            {
            }
            column(VATCalculationCaption; "VAT Entry".FieldCaption("VAT Calculation Type"))
            {
            }
            column(BilltoPaytoNoCaption; "VAT Entry".FieldCaption("Bill-to/Pay-to No."))
            {
            }
            column(EntryNoCaption; "VAT Entry".FieldCaption("Entry No."))
            {
            }
            column(DateCaption; VATDateLbl)
            {
            }
            dataitem("Closing G/L and VAT Entry"; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(VATBusPstGr_VATPostSetup; "VAT Posting Setup"."VAT Bus. Posting Group")
                {
                }
                column(VATPrdPstGr_VATPostSetup; "VAT Posting Setup"."VAT Prod. Posting Group")
                {
                }
                column(VATEntryGetFilterType; VATEntry.GetFilter(Type))
                {
                }
                column(VATEntryGetFiltTaxJurisCd; VATEntry.GetFilter("Tax Jurisdiction Code"))
                {
                }
                column(VATEntryGetFilterUseTax; VATEntry.GetFilter("Use Tax"))
                {
                }
                dataitem("VAT Entry"; "VAT Entry")
                {
                    DataItemTableView = sorting(Type, Closed) where(Type = filter(Purchase));
                    column(VATDate_VATEntry; Format("VAT Reporting Date"))
                    {
                    }
                    column(DocumentNo_VATEntry; "Document No.")
                    {
                        IncludeCaption = false;
                    }
                    column(DocumentType_VATEntry; "Document Type")
                    {
                    }
                    column(Type_VATEntry; Type)
                    {
                        IncludeCaption = false;
                    }
                    column(Base_VATEntry; Base)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(Amount_VATEntry; Amount)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(VATCalcType_VATEntry; "VAT Calculation Type")
                    {
                    }
                    column(BilltoPaytoNo_VATEntry; "Bill-to/Pay-to No.")
                    {
                    }
                    column(EntryNo_VATEntry; "Entry No.")
                    {
                    }
                    column(UserID_VATEntry; "User ID")
                    {
                    }
                    column(UnrealizedAmount_VATEntry; "Unrealized Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(UnrealizedBase_VATEntry; "Unrealized Base")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(AddCurrUnrlzdAmt_VATEntry; "Add.-Currency Unrealized Amt.")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(AddCurrUnrlzdBas_VATEntry; "Add.-Currency Unrealized Base")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(AdditionlCurrAmt_VATEntry; "Additional-Currency Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(AdditinlCurrBase_VATEntry; "Additional-Currency Base")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(ClosedbyEntryNo; DocumentNumbers)
                    {

                    }
                    column(DocumentDates; DocumentDates)
                    {
                    }
                    column(JournalBatchName; JournalBatchName)
                    {
                    }
                    column(SourceCode; SourceCodes)
                    {
                    }
                    column(FormToPay; FormToPayCodes)
                    {
                    }
                    column(PaymentMethod; PaymentMethodCodes)
                    {
                    }
                    column(UUID; UUIDs)
                    {
                    }
                    column(FiscalInvoiceNumberPAC; FiscalInvoiceNumberPAC)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        TempDocumentDates: Text;
                        TempJournalBatchName: Code[10];
                        TempSourceCode: Code[10];
                    begin
                        DocumentNumbers := GetAppliedDocumentsFromVAT("Entry No.");
                        TempDocumentDates := GetAppliedDocumentDates("Entry No.");
                        TempJournalBatchName := GetJournalBatchName("Entry No.");
                        GetVendorLedgerInfo("Entry No.", TempSourceCode, TempJournalBatchName);
                        GetPaymentMethodsFromVAT("Entry No.", PaymentMethodCode, FormToPayCode);

                        GetAllInvoiceFieldsFromVAT("Entry No.", SourceCodes, FormToPayCodes, PaymentMethodCodes, UUIDs, DocumentDates, JournalBatchName);
                        FiscalInvoiceNumberPAC := GetSimpleFiscalInvoiceNumberPAC("Entry No.");

                        if DocumentDates = '' then
                            DocumentDates := TempDocumentDates;
                        if JournalBatchName = '' then
                            JournalBatchName := TempJournalBatchName;
                        if SourceCodes = '' then
                            SourceCodes := TempSourceCode;

                        if not PrintVATEntries then
                            CurrReport.Skip();
                    end;

                    trigger OnPreDataItem()
                    begin
                        CopyFilters(VATEntry);
                        SetRange("Document Type", "Document Type"::Payment);
                    end;
                }
                dataitem("Close VAT Entries"; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    MaxIteration = 1;
                    column(PostingDate1; Format(PostingDate))
                    {
                    }
                    column(GenJnlLineDocumentNo; GenJnlLine."Document No.")
                    {
                    }
                    column(GenJnlLineVATBaseAmount; GenJnlLine."VAT Base Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLineVATAmount; GenJnlLine."VAT Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLnVATCalcType; Format(GenJnlLine."VAT Calculation Type"))
                    {
                    }
                    column(NextVATEntryNo; NextVATEntryNo)
                    {
                    }
                    column(GenJnlLnSrcCurrVATAmount; GenJnlLine."Source Curr. VAT Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLnSrcCurrVATBaseAmt; GenJnlLine."Source Curr. VAT Base Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine2Amount; GenJnlLine2.Amount)
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(GenJnlLine2DocumentNo; GenJnlLine2."Document No.")
                    {
                    }
                    column(ReversingEntry; ReversingEntry)
                    {
                    }
                    column(GenJnlLn2SrcCurrencyAmt; GenJnlLine2."Source Currency Amount")
                    {
                        AutoFormatExpression = GetCurrency();
                        AutoFormatType = 1;
                    }
                    column(SettlementCaption; SettlementCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATEntry.CalcSums(
                          Base, Amount,
                          "Additional-Currency Base", "Additional-Currency Amount",
                          "Non-Deductible VAT Amount", "Non-Deductible VAT Amount ACY");

                        ReversingEntry := false;
                        Clear(GenJnlLine);
                        GenJnlLine."System-Created Entry" := true;
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        case VATType of
                            VATEntry.Type::Purchase:
                                GenJnlLine.Description :=
                                  DelChr(
                                    StrSubstNo(
                                      Text007,
                                      "VAT Posting Setup"."VAT Bus. Posting Group",
                                      "VAT Posting Setup"."VAT Prod. Posting Group"),
                                    '>');
                            VATEntry.Type::Sale:
                                GenJnlLine.Description :=
                                  DelChr(
                                    StrSubstNo(
                                      Text008,
                                      "VAT Posting Setup"."VAT Bus. Posting Group",
                                      "VAT Posting Setup"."VAT Prod. Posting Group"),
                                    '>');
                        end;
                        SetVatPostingSetupToGenJnlLine(GenJnlLine, "VAT Posting Setup");
                        GenJnlLine."Posting Date" := PostingDate;
                        GenJnlLine."VAT Reporting Date" := VATDate;
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := DocNo;
                        GenJnlLine."Source Code" := SourceCodeSetup."VAT Settlement";
                        GenJnlLine."VAT Posting" := GenJnlLine."VAT Posting"::"Manual VAT Entry";
                        case "VAT Posting Setup"."VAT Calculation Type" of
                            "VAT Posting Setup"."VAT Calculation Type"::"Normal VAT",
                            "VAT Posting Setup"."VAT Calculation Type"::"Full VAT":
                                begin
                                    case VATType of
                                        VATEntry.Type::Purchase:
                                            GenJnlLine."Account No." := "VAT Posting Setup".GetPurchAccount(false);
                                        VATEntry.Type::Sale:
                                            GenJnlLine."Account No." := "VAT Posting Setup".GetSalesAccount(false);
                                    end;
                                    CopyAmounts(GenJnlLine, VATEntry);
                                    if PostSettlement then
                                        PostGenJnlLine(GenJnlLine);
                                    VATAmount := VATAmount + VATEntry.Amount;
                                    VATAmountAddCurr := VATAmountAddCurr + VATEntry."Additional-Currency Amount";
                                end;
                            "VAT Posting Setup"."VAT Calculation Type"::"Reverse Charge VAT":
                                case VATType of
                                    VATEntry.Type::Purchase:
                                        begin
                                            GenJnlLine."Account No." := "VAT Posting Setup".GetPurchAccount(false);
                                            CopyAmounts(GenJnlLine, VATEntry);
                                            if PostSettlement then
                                                PostGenJnlLine(GenJnlLine);

                                            CreateGenJnlLine(
                                                GenJnlLine2, "VAT Posting Setup".GetRevChargeAccount(false),
                                                VATEntry.Amount + VATEntry."Non-Deductible VAT Amount",
                                                VATEntry."Additional-Currency Amount" + VATEntry."Non-Deductible VAT Amount ACY");
                                            OnBeforePostGenJnlLineReverseChargeVAT(GenJnlLine2, VATEntry, VATAmount, VATAmountAddCurr);
                                            if PostSettlement then
                                                PostGenJnlLine(GenJnlLine2);
                                            VATAmount -= VATEntry."Non-Deductible VAT Amount";
                                            VATAmountAddCurr -= VATEntry."Non-Deductible VAT Amount ACY";
                                            ReversingEntry := true;
                                        end;
                                    VATEntry.Type::Sale:
                                        begin
                                            GenJnlLine."Account No." := "VAT Posting Setup".GetSalesAccount(false);
                                            CopyAmounts(GenJnlLine, VATEntry);
                                            if PostSettlement then
                                                PostGenJnlLine(GenJnlLine);

                                            OnCloseVATEntriesOnAfterPostGenJnlLineReverseChargeVATSales(
                                                VATEntry, GenJnlLine, GenJnlPostLine, "VAT Posting Setup", PostSettlement, ReversingEntry, DocNo, PostingDate, GenJnlLine2);
                                        end;
                                end;
                            "VAT Posting Setup"."VAT Calculation Type"::"Sales Tax":
                                begin
                                    TaxJurisdiction.Get(VATEntry."Tax Jurisdiction Code");
                                    GenJnlLine."Tax Area Code" := TaxJurisdiction.Code;
                                    GenJnlLine."Use Tax" := VATEntry."Use Tax";
                                    case VATType of
                                        VATEntry.Type::Purchase:
                                            if VATEntry."Use Tax" then begin
                                                TaxJurisdiction.TestField("Tax Account (Purchases)");
                                                GenJnlLine."Account No." := TaxJurisdiction."Tax Account (Purchases)";
                                                CopyAmounts(GenJnlLine, VATEntry);
                                                if PostSettlement then
                                                    PostGenJnlLine(GenJnlLine);

                                                TaxJurisdiction.TestField("Reverse Charge (Purchases)");
                                                CreateGenJnlLine(
                                                    GenJnlLine2, TaxJurisdiction."Reverse Charge (Purchases)", VATEntry.Amount, VATEntry."Additional-Currency Amount");
                                                GenJnlLine2."Tax Area Code" := TaxJurisdiction.Code;
                                                GenJnlLine2."Use Tax" := VATEntry."Use Tax";
                                                if PostSettlement then
                                                    PostGenJnlLine(GenJnlLine2);
                                                ReversingEntry := true;
                                            end else begin
                                                TaxJurisdiction.TestField("Tax Account (Purchases)");
                                                GenJnlLine."Account No." := TaxJurisdiction."Tax Account (Purchases)";
                                                CopyAmounts(GenJnlLine, VATEntry);
                                                if PostSettlement then
                                                    PostGenJnlLine(GenJnlLine);
                                                VATAmount := VATAmount + VATEntry.Amount;
                                                VATAmountAddCurr := VATAmountAddCurr + VATEntry."Additional-Currency Amount";
                                            end;
                                        VATEntry.Type::Sale:
                                            begin
                                                TaxJurisdiction.TestField("Tax Account (Sales)");
                                                GenJnlLine."Account No." := TaxJurisdiction."Tax Account (Sales)";
                                                CopyAmounts(GenJnlLine, VATEntry);
                                                if PostSettlement then
                                                    PostGenJnlLine(GenJnlLine);
                                                VATAmount := VATAmount + VATEntry.Amount;
                                                VATAmountAddCurr := VATAmountAddCurr + VATEntry."Additional-Currency Amount";
                                            end;
                                    end;
                                end;
                        end;
                        NextVATEntryNo := GetSettlementVATEntryNo(PostSettlement);

                        // Close current VAT entries
                        if PostSettlement and (NextVATEntryNo <> 0) then
                            CloseVATEntriesOnPostSettlement(VATEntry, NextVATEntryNo);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    VATEntry.Reset();
                    VATEntry.SetRange(Type, VATType);

                    VATEntry.SetFilter("VAT Reporting Date", DateFilter);
                    VATEntry.SetRange("VAT Bus. Posting Group", "VAT Posting Setup"."VAT Bus. Posting Group");
                    VATEntry.SetRange("VAT Prod. Posting Group", "VAT Posting Setup"."VAT Prod. Posting Group");
                    if CountryRegionFilter <> '' then
                        VATEntry.SetFilter("Country/Region Code", CountryRegionFilter);

                    OnClosingGLAndVATEntryOnAfterGetRecordOnAfterSetVATEntryFilters("VAT Posting Setup", VATEntry, "VAT Entry");

                    case "VAT Posting Setup"."VAT Calculation Type" of
                        "VAT Posting Setup"."VAT Calculation Type"::"Normal VAT",
                        "VAT Posting Setup"."VAT Calculation Type"::"Reverse Charge VAT",
                        "VAT Posting Setup"."VAT Calculation Type"::"Full VAT":
                            begin
                                VATEntry.SetCurrentKey(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "VAT Reporting Date");
                                if FindFirstEntry then begin
                                    if not VATEntry.Find('-') then
                                        if VATType = VATEntry.Type::Purchase then begin
                                            VATType := VATEntry.Type::Settlement;
                                        end;
                                    FindFirstEntry := false;
                                end else
                                    if VATEntry.Next() = 0 then
                                        if VATType = VATEntry.Type::Purchase then begin
                                            VATType := VATEntry.Type::Settlement;
                                        end;

                                if IsNotSettlement(VATType) then
                                    VATEntry.Find('+');
                            end;
                        "VAT Posting Setup"."VAT Calculation Type"::"Sales Tax":
                            begin
                                VATEntry.SetCurrentKey(Type, Closed, "Tax Jurisdiction Code", "Use Tax", "VAT Reporting Date");
                                if FindFirstEntry then begin
                                    if not VATEntry.Find('-') then
                                        if VATType = VATEntry.Type::Purchase then begin
                                            VATType := VATEntry.Type::Settlement;
                                        end;
                                    FindFirstEntry := false;
                                end else begin
                                    VATEntry.SetRange("Tax Jurisdiction Code");
                                    VATEntry.SetRange("Use Tax");
                                    if VATEntry.Next() = 0 then
                                        if VATType = VATEntry.Type::Purchase then begin
                                            VATType := VATEntry.Type::Settlement;
                                        end;
                                end;
                                if IsNotSettlement(VATType) then begin
                                    VATEntry.SetRange("Tax Jurisdiction Code", VATEntry."Tax Jurisdiction Code");
                                    VATEntry.SetRange("Use Tax", VATEntry."Use Tax");
                                    VATEntry.Find('+');
                                end;
                            end;
                    end;

                    if VATType = VATEntry.Type::Settlement then
                        CurrReport.Break();
                end;

                trigger OnPreDataItem()
                begin
                    VATType := VATEntry.Type::Purchase;
                    FindFirstEntry := true;
                end;
            }

            trigger OnPostDataItem()
            begin
                // Post to settlement account
                if VATAmount <> 0 then begin
                    GenJnlLine.Init();
                    GenJnlLine."System-Created Entry" := true;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";

                    GLAccSettle.TestField("Gen. Posting Type", GenJnlLine."Gen. Posting Type"::" ");
                    GLAccSettle.TestField("VAT Bus. Posting Group", '');
                    GLAccSettle.TestField("VAT Prod. Posting Group", '');
                    if VATPostingSetup.Get(GLAccSettle."VAT Bus. Posting Group", GLAccSettle."VAT Prod. Posting Group") then
                        VATPostingSetup.TestField("VAT %", 0);
                    GLAccSettle.TestField("Gen. Bus. Posting Group", '');
                    GLAccSettle.TestField("Gen. Prod. Posting Group", '');

                    GenJnlLine.Validate("Account No.", GLAccSettle."No.");
                    GenJnlLine."Posting Date" := PostingDate;
                    GenJnlLine."VAT Reporting Date" := VATDate;
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := DocNo;
                    GenJnlLine.Description := Text004;
                    GenJnlLine.Amount := VATAmount;
                    GenJnlLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
                    GenJnlLine."Source Currency Amount" := VATAmountAddCurr;
                    GenJnlLine."Source Code" := SourceCodeSetup."VAT Settlement";
                    GenJnlLine."VAT Posting" := GenJnlLine."VAT Posting"::"Manual VAT Entry";
                    if PostSettlement then
                        PostGenJnlLine(GenJnlLine);
                end;
            end;

            trigger OnPreDataItem()
            begin
                GLEntry.LockTable(); // Avoid deadlock with function 12
                if GLEntry.FindLast() then;
                VATEntry.LockTable();
                VATEntry.Reset();
                NextVATEntryNo := VATEntry.GetLastEntryNo();

                SourceCodeSetup.Get();
                GLSetup.Get();
                VATAmount := 0;
                VATAmountAddCurr := 0;

                if UseAmtsInAddCurr then
                    HeaderText := StrSubstNo(AllAmountsAreInTxt, GLSetup."Additional Reporting Currency")
                else begin
                    GLSetup.TestField("LCY Code");
                    HeaderText := StrSubstNo(AllAmountsAreInTxt, GLSetup."LCY Code");
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        ShowFilter = false;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(StartingDate; EntrdStartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fecha inicial';
                        ToolTip = 'Specifies the first date in the period from which VAT entries are processed in the batch job.';
                    }
                    field(EndDateReq; EnteredEndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fecha final';
                        ToolTip = 'Specifies the last date in the period from which VAT entries are processed in the batch job.';
                    }
                    field(PostingDt; PostingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fecha registro';
                        ToolTip = 'Specifies the date on which the transfer to the VAT account is posted. This field must be filled in.';

                        trigger OnValidate()
                        begin
                            VATDate := PostingDate;
                        end;
                    }
                    field(VATDt; VATDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = IsVATDateEnabled;
                        Caption = 'Fecha IVA';
                        ToolTip = 'Specifies the VAT date for the transfer to the VAT account. This field must be filled in.';
                    }
                    field(DocumentNo; DocNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. Documento';
                        ToolTip = 'Specifies a document number. This field must be filled in.';
                    }
                    field(SettlementAcc; GLAccSettle."No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cuenta de liquidación';
                        TableRelation = "G/L Account";
                        ToolTip = 'Specifies the number of the VAT settlement account. Select the field to see the chart of account. This field must be filled in.';

                        trigger OnValidate()
                        begin
                            if GLAccSettle."No." <> '' then begin
                                GLAccSettle.Find();
                                GLAccSettle.CheckGLAcc();
                            end;
                        end;
                    }
                    field(ShowVATEntries; PrintVATEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mostrar entradas de IVA';
                        ToolTip = 'Specifies if you want the report that is printed during the batch job to contain the individual VAT entries. If you do not choose to print the VAT entries, the settlement amount is shown only for each VAT posting group.';
                    }
                    field(Post; PostSettlement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Correo';
                        ToolTip = 'Specifies if you want the program to post the transfer to the VAT settlement account automatically. If you do not choose to post the transfer, the batch job only prints a test report, and Test Report (not Posted) appears on the report.';
                    }
                    field(AmtsinAddReportingCurr; UseAmtsInAddCurr)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mostrar importes en la moneda de informe adicional';
                        MultiLine = true;
                        ToolTip = 'Specifies if the reported amounts are shown in the additional reporting currency.';
                    }
                    field("Country/Region Filter"; CountryRegionFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Filtro de país/región';
                        ToolTip = 'Specifies the country/region to filter the VAT entries.';
                        Importance = Additional;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CountryRegion: Record "Country/Region";
                            CountriesRegions: Page "Countries/Regions";
                        begin
                            CountriesRegions.LookupMode(true);
                            if CountriesRegions.RunModal() = Action::LookupOK then begin
                                CountriesRegions.GetRecord(CountryRegion);
                                CountryRegionFilter := CountryRegion.Code;
                                exit(true);
                            end;
                            exit(false);
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if GenJnlPostLine.IsGLEntryInconsistent() then
            GenJnlPostLine.ShowInconsistentEntries();
        OnAfterPostReport();
    end;

    trigger OnPreReport()
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        OnBeforePreReport("VAT Posting Setup", PostSettlement, GLAccSettle);

        if PostingDate = 0D then
            Error(Text000);

        if VATDate = 0D then
            if IsVATDateEnabled then
                Error(EnterVATDateLbl)
            else
                VATDate := PostingDate;

        if DocNo = '' then
            Error(Text001);
        if GLAccSettle."No." = '' then
            Error(Text002);
        GLAccSettle.Find();

        if PostSettlement and not Initialized then
            if not ConfirmManagement.GetResponseOrDefault(Text003, true) then
                CurrReport.Quit();

        VATPostingSetupFilter := "VAT Posting Setup".GetFilters();
        CreateVATDateFilter();
        Clear(GenJnlPostLine);
        lf[1] := 10;

        OnAfterPreReport("VAT Entry");
    end;

    trigger OnInitReport()
    var
        VATReportingDateMgt: Codeunit "VAT Reporting Date Mgt";
    begin
        IsVATDateEnabled := VATReportingDateMgt.IsVATDateEnabled();
    end;

    var
        FiscalInvoiceNumberPAC: Text;
        lf: Text[1];
        SourceCodes: Text;
        FormToPayCodes: Text;
        PaymentMethodCodes: Text;
        UUIDs: Text;
        PaymentMethodCode: Code[10];
        FormToPayCode: Code[10];
        DocumentNumbers: Text;
        DocumentDates: Text;
        SourceCode: Code[10];
        JournalBatchName: Text;
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        TaxJurisdiction: Record "Tax Jurisdiction";
        GLSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PrintVATEntries: Boolean;
        NextVATEntryNo: Integer;
        PostingDate: Date;
        VATDate: Date;
        DocNo: Code[20];
        VATType: Enum "General Posting Type";
        VATAmount: Decimal;
        VATAmountAddCurr: Decimal;
        FindFirstEntry: Boolean;
        ReversingEntry: Boolean;
        Initialized: Boolean;
        VATPostingSetupFilter: Text;
        DateFilter: Text;
        UseAmtsInAddCurr: Boolean;
        HeaderText: Text[30];
        CountryRegionFilter: Text;
        IsVATDateEnabled: Boolean;
#pragma warning disable AA0074
        Text000: Label 'Introduzca la fecha registro.';
        Text001: Label 'Introduzca el no. documento';
        Text002: Label 'Introduzca la cuenta de liquidación.';
        Text003: Label '¿Quieres calcular y contabilizar la Liquidación del IVA?';
        Text004: Label 'Liquidación del IVA';
#pragma warning disable AA0470
        Text005: Label 'Periodo: %1';
#pragma warning restore AA0470
#pragma warning restore AA0074
        AllAmountsAreInTxt: Label 'All amounts are in %1.', Comment = '%1 = Currency Code';
#pragma warning disable AA0074
#pragma warning disable AA0470
        Text007: Label 'Purchase VAT settlement: #1######## #2########';
        Text008: Label 'Sales VAT settlement  : #1######## #2########';
#pragma warning restore AA0470
#pragma warning restore AA0074
        EnterVATDateLbl: Label 'Introduzca la fecha de IVA';
        CalcandPostVATSettlementCaptionLbl: Label 'Calcular y contabilizar la liquidación del IVA';
        PageCaptionLbl: Label 'Pagina';
        TestReportnotpostedCaptionLbl: Label 'Informe de Prueba (No Publicado)';
        DocNoCaptionLbl: Label 'No. Documento';
        SettlementAccCaptionLbl: Label 'Cuenta de liquidación';
        DocumentTypeCaptionLbl: Label 'Tipo documento';
        UserIDCaptionLbl: Label 'User ID';
        TotalCaptionLbl: Label 'Total';
        SettlementCaptionLbl: Label 'Liquidación';
        VATDateLbl: Label 'Fecha IVA';

    protected var
        GLAccSettle: Record "G/L Account";
        PostSettlement: Boolean;
        EntrdStartDate: Date;
        EnteredEndDate: Date;

    procedure GetSimpleFiscalInvoiceNumberPAC(VATEntryNo: Integer): Text
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        // Si no existe el VAT Entry, retornar vacío
        if not VATEntry.Get(VATEntryNo) then
            exit('');

        // Buscar en Vendor Ledger Entry con la información del VAT Entry
        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            // Verificar si tiene Fiscal Invoice Number PAC en el movimiento de proveedor
            if VendLedgerEntry."Fiscal Invoice Number PAC" <> '' then
                exit(VendLedgerEntry."Fiscal Invoice Number PAC");

            // Si es una factura, verificar en Purchase Invoice Header
            if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
                if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                    if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then
                        exit(PurchInvHeader."Fiscal Invoice Number PAC");
                end;
            end;
        end;

        // Si no se encuentra nada, retornar vacío
        exit('');
    end;

    procedure GetAllInvoiceFieldsFromVAT(VATEntryNo: Integer; var OutSourceCodes: Text; var OutFormToPayCodes: Text; var OutPaymentMethodCodes: Text; var OutUUIDs: Text; var OutDocumentDates: Text; var OutJournalBatchNames: Text)
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        ProcessedEntries: List of [Integer];
        FoundDirectRelation: Boolean;
        TempDocumentNumbers: Text;
    begin
        OutSourceCodes := '';
        OutFormToPayCodes := '';
        OutPaymentMethodCodes := '';
        OutUUIDs := '';
        OutDocumentDates := '';
        OutJournalBatchNames := '';
        TempDocumentNumbers := '';
        FoundDirectRelation := false;

        if not VATEntry.Get(VATEntryNo) then
            exit;

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            FoundDirectRelation := true;
            if VendLedgerEntry."Remaining Amount" = 0 then begin
                GetAllAppliedInvoiceFields(VendLedgerEntry."Entry No.", OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, TempDocumentNumbers);
            end else begin
                GetInvoiceFieldsFromSingleEntry(VendLedgerEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, TempDocumentNumbers);
            end;
        end;

        if not FoundDirectRelation then begin
            SearchDirectlyInVendorLedgerByDocAndDate(VATEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, TempDocumentNumbers);
        end
        else if (OutUUIDs = '') or (OutSourceCodes = '') then begin
            SearchDirectlyInVendorLedgerByDocAndDate(VATEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, TempDocumentNumbers);
        end;

        DocumentNumbers := TempDocumentNumbers;
    end;


    local procedure SearchDirectlyInVendorLedgerByDocAndDate(
         VATEntry: Record "VAT Entry";
         var OutSourceCodes: Text;
         var OutFormToPayCodes: Text;
         var OutPaymentMethodCodes: Text;
         var OutUUIDs: Text;
         var OutDocumentDates: Text;
         var OutJournalBatchNames: Text;
         var OutDocumentNumbers: Text)
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        ProcessedEntries: List of [Integer];
    begin
        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");

        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedEntries.Contains(VendLedgerEntry."Entry No.") then begin
                    if VendLedgerEntry."Remaining Amount" = 0 then
                        GetAllAppliedInvoiceFields(
                            VendLedgerEntry."Entry No.",
                            OutSourceCodes,
                            OutFormToPayCodes,
                            OutPaymentMethodCodes,
                            OutUUIDs,
                            OutDocumentDates,
                            OutJournalBatchNames,
                            OutDocumentNumbers)
                    else
                        GetInvoiceFieldsFromSingleEntry(
                            VendLedgerEntry,
                            OutSourceCodes,
                            OutFormToPayCodes,
                            OutPaymentMethodCodes,
                            OutUUIDs,
                            OutDocumentDates,
                            OutJournalBatchNames,
                            OutDocumentNumbers);

                    ProcessedEntries.Add(VendLedgerEntry."Entry No.");

                    if (OutUUIDs <> '') and (OutSourceCodes <> '') then
                        exit;
                end;
            until VendLedgerEntry.Next() = 0;

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetFilter("Amount", '<0');
        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedEntries.Contains(VendLedgerEntry."Entry No.") then begin
                    if VendLedgerEntry."Remaining Amount" = 0 then
                        GetAllAppliedInvoiceFields(
                            VendLedgerEntry."Entry No.",
                            OutSourceCodes,
                            OutFormToPayCodes,
                            OutPaymentMethodCodes,
                            OutUUIDs,
                            OutDocumentDates,
                            OutJournalBatchNames,
                            OutDocumentNumbers);

                    ProcessedEntries.Add(VendLedgerEntry."Entry No.");

                    if (OutUUIDs <> '') and (OutSourceCodes <> '') then
                        exit;
                end;
            until VendLedgerEntry.Next() = 0;
    end;

    local procedure GetInvoiceFieldsFromSingleEntry(VendLedgerEntry: Record "Vendor Ledger Entry"; var OutSourceCodes: Text; var OutFormToPayCodes: Text; var OutPaymentMethodCodes: Text; var OutUUIDs: Text; var OutDocumentDates: Text; var OutJournalBatchNames: Text; var OutDocumentNumbers: Text)
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        UUID: Text;
    begin
        OutSourceCodes := VendLedgerEntry."Source Code";
        OutPaymentMethodCodes := VendLedgerEntry."Payment Method Code";
        OutJournalBatchNames := VendLedgerEntry."Journal Batch Name";
        OutDocumentDates := Format(VendLedgerEntry."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');

        OutDocumentNumbers := VendLedgerEntry."Document No.";

        if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
            if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                OutFormToPayCodes := PurchInvHeader."Form to Pay";

                if OutPaymentMethodCodes = '' then
                    OutPaymentMethodCodes := PurchInvHeader."Payment Method Code";
            end;
        end;

        UUID := GetFiscalInvoiceNumbers(GetVATEntryNoFromVendorEntry(VendLedgerEntry));
        OutUUIDs := UUID;
    end;

    procedure GetJournalBatchName(VATEntryNo: Integer): Text
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        JournalBatchName: Text;
    begin
        JournalBatchName := '';

        if not VATEntry.Get(VATEntryNo) then
            exit('');

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            if VendLedgerEntry."Journal Batch Name" <> '' then
                exit(VendLedgerEntry."Journal Batch Name");
        end;

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Posting Date");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            if VendLedgerEntry."Journal Batch Name" <> '' then
                exit(VendLedgerEntry."Journal Batch Name");
        end;

        exit('');
    end;

    local procedure GetVATEntryNoFromVendorEntry(VendLedgerEntry: Record "Vendor Ledger Entry"): Integer
    var
        VATEntry: Record "VAT Entry";
    begin
        VATEntry.Reset();
        VATEntry.SetCurrentKey("Document No.", "Posting Date");
        VATEntry.SetRange("Document No.", VendLedgerEntry."Document No.");
        VATEntry.SetRange("Document Type", VendLedgerEntry."Document Type");
        VATEntry.SetRange("Bill-to/Pay-to No.", VendLedgerEntry."Vendor No.");
        VATEntry.SetRange("Posting Date", VendLedgerEntry."Posting Date");
        VATEntry.SetRange(Type, VATEntry.Type::Purchase);

        if VATEntry.FindFirst() then
            exit(VATEntry."Entry No.");

        exit(0);
    end;

    local procedure GetAllAppliedInvoiceFields(EntryNo: Integer; var OutSourceCodes: Text; var OutFormToPayCodes: Text; var OutPaymentMethodCodes: Text; var OutUUIDs: Text; var OutDocumentDates: Text; var OutJournalBatchNames: Text; var OutDocumentNumbers: Text)
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DetailedVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        ProcessedEntries: List of [Integer];
    begin
        OutSourceCodes := '';
        OutFormToPayCodes := '';
        OutPaymentMethodCodes := '';
        OutUUIDs := '';
        OutDocumentDates := '';
        OutJournalBatchNames := '';
        OutDocumentNumbers := '';

        if not VendLedgerEntry.Get(EntryNo) then
            exit;

        DetailedVendLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.");
        DetailedVendLedgEntry1.SetRange("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry1.SetRange(Unapplied, false);

        if DetailedVendLedgEntry1.Find('-') then
            repeat
                if DetailedVendLedgEntry1."Vendor Ledger Entry No." = DetailedVendLedgEntry1."Applied Vend. Ledger Entry No." then begin
                    DetailedVendLedgEntry2.Reset();
                    DetailedVendLedgEntry2.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
                    DetailedVendLedgEntry2.SetRange("Applied Vend. Ledger Entry No.", DetailedVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DetailedVendLedgEntry2.SetRange("Entry Type", DetailedVendLedgEntry2."Entry Type"::Application);
                    DetailedVendLedgEntry2.SetRange(Unapplied, false);

                    if DetailedVendLedgEntry2.Find('-') then
                        repeat
                            if DetailedVendLedgEntry2."Vendor Ledger Entry No." <> DetailedVendLedgEntry2."Applied Vend. Ledger Entry No." then begin
                                if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry2."Vendor Ledger Entry No.") then
                                    if not ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") then begin
                                        AddInvoiceFieldsFromEntry(AppliedVendLedgerEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, OutDocumentNumbers);
                                        ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                                    end;
                            end;
                        until DetailedVendLedgEntry2.Next() = 0;
                end else begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry1."Applied Vend. Ledger Entry No.") then
                        if not ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") then begin
                            AddInvoiceFieldsFromEntry(AppliedVendLedgerEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, OutDocumentNumbers);
                            ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                        end;
                end;
            until DetailedVendLedgEntry1.Next() = 0;

        if VendLedgerEntry."Closed by Entry No." <> 0 then begin
            if AppliedVendLedgerEntry.Get(VendLedgerEntry."Closed by Entry No.") then
                if not ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") then begin
                    AddInvoiceFieldsFromEntry(AppliedVendLedgerEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, OutDocumentNumbers);
                    ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                end;
        end;

        AppliedVendLedgerEntry.Reset();
        AppliedVendLedgerEntry.SetCurrentKey("Closed by Entry No.");
        AppliedVendLedgerEntry.SetRange("Closed by Entry No.", VendLedgerEntry."Entry No.");
        if AppliedVendLedgerEntry.Find('-') then
            repeat
                if not ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") then begin
                    AddInvoiceFieldsFromEntry(AppliedVendLedgerEntry, OutSourceCodes, OutFormToPayCodes, OutPaymentMethodCodes, OutUUIDs, OutDocumentDates, OutJournalBatchNames, OutDocumentNumbers);
                    ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                end;
            until AppliedVendLedgerEntry.Next() = 0;
    end;

    local procedure AddInvoiceFieldsFromEntry(AppliedVendLedgerEntry: Record "Vendor Ledger Entry"; var OutSourceCodes: Text; var OutFormToPayCodes: Text; var OutPaymentMethodCodes: Text; var OutUUIDs: Text; var OutDocumentDates: Text; var OutJournalBatchNames: Text; var OutDocumentNumbers: Text)
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        TempJournalBatchName: Code[10];
        TempSourceCode: Code[10];
        TempFormToPay: Code[10];
        TempPaymentMethod: Code[10];
        TempUUID: Text;
        TempDocumentDate: Text;
        TempDocumentNumber: Code[20];
    begin
        if AppliedVendLedgerEntry."Document Type" <> AppliedVendLedgerEntry."Document Type"::Invoice then
            exit;

        TempJournalBatchName := AppliedVendLedgerEntry."Journal Batch Name";
        TempSourceCode := AppliedVendLedgerEntry."Source Code";
        TempPaymentMethod := AppliedVendLedgerEntry."Payment Method Code";
        TempDocumentDate := Format(AppliedVendLedgerEntry."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        TempDocumentNumber := AppliedVendLedgerEntry."Document No.";

        if PurchInvHeader.Get(AppliedVendLedgerEntry."Document No.") then begin
            TempFormToPay := PurchInvHeader."Form to Pay";

            if TempPaymentMethod = '' then
                TempPaymentMethod := PurchInvHeader."Payment Method Code";
        end;

        TempUUID := GetFiscalInvoiceNumbersFromVendorEntry(AppliedVendLedgerEntry);

        OutSourceCodes := AddFieldWithLineBreak(OutSourceCodes, TempSourceCode);
        OutFormToPayCodes := AddFieldWithLineBreak(OutFormToPayCodes, TempFormToPay);
        OutPaymentMethodCodes := AddFieldWithLineBreak(OutPaymentMethodCodes, TempPaymentMethod);
        OutUUIDs := AddFieldWithLineBreak(OutUUIDs, TempUUID);
        OutDocumentDates := AddFieldWithLineBreak(OutDocumentDates, TempDocumentDate);
        OutJournalBatchNames := AddFieldWithLineBreak(OutJournalBatchNames, TempJournalBatchName);
        OutDocumentNumbers := AddFieldWithLineBreak(OutDocumentNumbers, TempDocumentNumber);
    end;

    local procedure GetFiscalInvoiceNumbersFromVendorEntry(VendLedgerEntry: Record "Vendor Ledger Entry"): Text
    var
        VATEntry: Record "VAT Entry";
        TempVATEntryNo: Integer;
    begin
        VATEntry.Reset();
        VATEntry.SetCurrentKey("Document No.", "Posting Date");
        VATEntry.SetRange("Document No.", VendLedgerEntry."Document No.");
        VATEntry.SetRange("Document Type", VendLedgerEntry."Document Type");
        VATEntry.SetRange("Bill-to/Pay-to No.", VendLedgerEntry."Vendor No.");
        VATEntry.SetRange("Posting Date", VendLedgerEntry."Posting Date");
        VATEntry.SetRange(Type, VATEntry.Type::Purchase);

        if VATEntry.FindFirst() then begin
            TempVATEntryNo := VATEntry."Entry No.";
            exit(GetFiscalInvoiceNumbers(TempVATEntryNo));
        end;

        exit(GetFiscalInvoiceNumbersDirectFromVendorEntry(VendLedgerEntry));
    end;

    local procedure GetFiscalInvoiceNumbersDirectFromVendorEntry(VendLedgerEntry: Record "Vendor Ledger Entry"): Text
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if VendLedgerEntry."Fiscal Invoice Number PAC" <> '' then
            exit(VendLedgerEntry."Fiscal Invoice Number PAC");

        if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
            if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then
                    exit(PurchInvHeader."Fiscal Invoice Number PAC");
            end;
        end;

        exit('');
    end;

    local procedure AddFieldWithLineBreak(CurrentFields: Text; NewField: Text): Text
    begin
        if NewField = '' then
            NewField := ' ';

        if CurrentFields <> '' then
            CurrentFields += lf;

        CurrentFields += NewField;
        exit(CurrentFields);
    end;
    //summary>
    /// InitializeRequest with "VAT Date" default to "Posting Date"
    //</summary>
    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewPostingDate: Date; NewDocNo: Code[20]; NewSettlementAcc: Code[20]; ShowVATEntries: Boolean; Post: Boolean)
    begin
        InitializeRequest(NewStartDate, NewEndDate, NewPostingDate, NewPostingDate, NewDocNo, NewSettlementAcc, ShowVATEntries, Post);
    end;

    /// <summary>
    /// InitializeRequest with specified "VAT Date"
    /// </summary>
    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewPostingDate: Date; NewVATDate: Date; NewDocNo: Code[20]; NewSettlementAcc: Code[20]; ShowVATEntries: Boolean; Post: Boolean)
    begin
        EntrdStartDate := NewStartDate;
        EnteredEndDate := NewEndDate;
        PostingDate := NewPostingDate;
        VATDate := NewVATDate;
        DocNo := NewDocNo;
        GLAccSettle."No." := NewSettlementAcc;
        PrintVATEntries := ShowVATEntries;
        PostSettlement := Post;
        Initialized := true;
    end;

    procedure GetFiscalInvoiceNumbers(VATEntryNo: Integer): Text
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        FiscalNumbers: Text;
        ProcessedDocuments: List of [Code[20]];
        FoundVendorMovement: Boolean;
    begin
        FiscalNumbers := '';
        FoundVendorMovement := false;
        if not VATEntry.Get(VATEntryNo) then
            exit('');

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            FoundVendorMovement := true;
            FiscalNumbers := ProcessVendorLedgerEntry(VendLedgerEntry, ProcessedDocuments);

            if FiscalNumbers = '' then
                FiscalNumbers := SearchInSettledMovements(VendLedgerEntry, ProcessedDocuments);
        end;

        if not FoundVendorMovement or (FiscalNumbers = '') then begin
            FiscalNumbers := SearchDirectInVendorMovements(VATEntry, ProcessedDocuments);
        end;

        if FiscalNumbers = '' then begin
            FiscalNumbers := SearchAdditionalVendorMovements(VATEntry, ProcessedDocuments);
        end;

        exit(FiscalNumbers);
    end;

    local procedure SearchDirectInVendorMovements(VATEntry: Record "VAT Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := '';

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Posting Date");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(VendLedgerEntry."Document No.") then begin
                    FiscalNumbers := ProcessVendorLedgerEntry(VendLedgerEntry, ProcessedDocuments);

                    if FiscalNumbers = '' then
                        FiscalNumbers := SearchInSettledMovements(VendLedgerEntry, ProcessedDocuments);

                    if FiscalNumbers <> '' then
                        break;
                end;
            until VendLedgerEntry.Next() = 0;

        exit(FiscalNumbers);
    end;

    local procedure ProcessVendorLedgerEntry(VendLedgerEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := '';
        if VendLedgerEntry."Fiscal Invoice Number PAC" <> '' then begin
            FiscalNumbers := AddFiscalNumber(FiscalNumbers, VendLedgerEntry."Fiscal Invoice Number PAC");
            ProcessedDocuments.Add(VendLedgerEntry."Document No.");
            exit(FiscalNumbers);
        end;
        if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
            if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then begin
                    FiscalNumbers := AddFiscalNumber(FiscalNumbers, PurchInvHeader."Fiscal Invoice Number PAC");
                    ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                    exit(FiscalNumbers);
                end;
            end;
        end;

        exit(FiscalNumbers);
    end;

    local procedure SearchVendorMovementsByDocAndDate(VATEntry: Record "VAT Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := '';

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(VendLedgerEntry."Document No.") then begin
                    if VendLedgerEntry."Fiscal Invoice Number PAC" <> '' then begin
                        FiscalNumbers := AddFiscalNumber(FiscalNumbers, VendLedgerEntry."Fiscal Invoice Number PAC");
                        ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                    end
                    else if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
                        if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                            if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then begin
                                FiscalNumbers := AddFiscalNumber(FiscalNumbers, PurchInvHeader."Fiscal Invoice Number PAC");
                                ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                            end;
                        end;
                    end;

                    if FiscalNumbers = '' then begin
                        FiscalNumbers := SearchInSettledMovements(VendLedgerEntry, ProcessedDocuments);
                    end;

                    if FiscalNumbers <> '' then
                        break;
                end;
            until VendLedgerEntry.Next() = 0;

        exit(FiscalNumbers);
    end;

    local procedure SearchInSettledMovements(var VendLedgerEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := '';

        DetailedVendLedgEntry.SetCurrentKey("Vendor Ledger Entry No.");
        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry.SetRange(Unapplied, false);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                if DetailedVendLedgEntry."Applied Vend. Ledger Entry No." <> DetailedVendLedgEntry."Vendor Ledger Entry No." then begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Applied Vend. Ledger Entry No.") then begin
                        if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                            FiscalNumbers := GetUUIDFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, FiscalNumbers);
                            if FiscalNumbers <> '' then
                                exit(FiscalNumbers);
                        end;
                    end;
                end;
            until DetailedVendLedgEntry.Next() = 0;

        DetailedVendLedgEntry.Reset();
        DetailedVendLedgEntry.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
        DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry.SetRange(Unapplied, false);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                if DetailedVendLedgEntry."Vendor Ledger Entry No." <> DetailedVendLedgEntry."Applied Vend. Ledger Entry No." then begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Vendor Ledger Entry No.") then begin
                        if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                            FiscalNumbers := GetUUIDFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, FiscalNumbers);
                            if FiscalNumbers <> '' then
                                exit(FiscalNumbers);
                        end;
                    end;
                end;
            until DetailedVendLedgEntry.Next() = 0;

        if VendLedgerEntry."Closed by Entry No." <> 0 then begin
            if AppliedVendLedgerEntry.Get(VendLedgerEntry."Closed by Entry No.") then begin
                if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                    FiscalNumbers := GetUUIDFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, FiscalNumbers);
                    if FiscalNumbers <> '' then
                        exit(FiscalNumbers);
                end;
            end;
        end;

        AppliedVendLedgerEntry.Reset();
        AppliedVendLedgerEntry.SetCurrentKey("Closed by Entry No.");
        AppliedVendLedgerEntry.SetRange("Closed by Entry No.", VendLedgerEntry."Entry No.");
        if AppliedVendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                    FiscalNumbers := GetUUIDFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, FiscalNumbers);
                    if FiscalNumbers <> '' then
                        exit(FiscalNumbers);
                end;
            until AppliedVendLedgerEntry.Next() = 0;

        exit(FiscalNumbers);
    end;

    local procedure GetUUIDFromVendorEntry(var VendLedgerEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]; CurrentFiscalNumbers: Text): Text
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := CurrentFiscalNumbers;

        if VendLedgerEntry."Fiscal Invoice Number PAC" <> '' then begin
            FiscalNumbers := AddFiscalNumber(FiscalNumbers, VendLedgerEntry."Fiscal Invoice Number PAC");
            ProcessedDocuments.Add(VendLedgerEntry."Document No.");
        end
        else if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
            if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then begin
                    FiscalNumbers := AddFiscalNumber(FiscalNumbers, PurchInvHeader."Fiscal Invoice Number PAC");
                    ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                end;
            end;
        end;

        exit(FiscalNumbers);
    end;

    local procedure SearchAdditionalVendorMovements(VATEntry: Record "VAT Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := '';

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", CalcDate('-7D', VATEntry."Posting Date"), CalcDate('+7D', VATEntry."Posting Date"));

        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(VendLedgerEntry."Document No.") then begin
                    if VendLedgerEntry."Fiscal Invoice Number PAC" <> '' then begin
                        FiscalNumbers := AddFiscalNumber(FiscalNumbers, VendLedgerEntry."Fiscal Invoice Number PAC");
                        ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                        break;
                    end
                    else if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
                        if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                            if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then begin
                                FiscalNumbers := AddFiscalNumber(FiscalNumbers, PurchInvHeader."Fiscal Invoice Number PAC");
                                ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                                break;
                            end;
                        end;
                    end;
                end;
            until VendLedgerEntry.Next() = 0;

        exit(FiscalNumbers);
    end;

    local procedure GetFiscalNumbersFromPaymentSettlement(PaymentEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]; CurrentFiscalNumbers: Text): Text
    var
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        FiscalNumbers: Text;
    begin
        FiscalNumbers := CurrentFiscalNumbers;

        DetailedVendLedgEntry.SetCurrentKey("Vendor Ledger Entry No.");
        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", PaymentEntry."Entry No.");
        DetailedVendLedgEntry.SetRange(Unapplied, false);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                if DetailedVendLedgEntry."Applied Vend. Ledger Entry No." <> DetailedVendLedgEntry."Vendor Ledger Entry No." then begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Applied Vend. Ledger Entry No.") then begin
                        if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin

                            if AppliedVendLedgerEntry."Fiscal Invoice Number PAC" <> '' then begin
                                FiscalNumbers := AddFiscalNumber(FiscalNumbers, AppliedVendLedgerEntry."Fiscal Invoice Number PAC");
                                ProcessedDocuments.Add(AppliedVendLedgerEntry."Document No.");
                            end
                            else if AppliedVendLedgerEntry."Document Type" = AppliedVendLedgerEntry."Document Type"::Invoice then begin
                                if PurchInvHeader.Get(AppliedVendLedgerEntry."Document No.") then begin
                                    if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then begin
                                        FiscalNumbers := AddFiscalNumber(FiscalNumbers, PurchInvHeader."Fiscal Invoice Number PAC");
                                        ProcessedDocuments.Add(AppliedVendLedgerEntry."Document No.");
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            until DetailedVendLedgEntry.Next() = 0;

        DetailedVendLedgEntry.Reset();
        DetailedVendLedgEntry.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
        DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", PaymentEntry."Entry No.");
        DetailedVendLedgEntry.SetRange(Unapplied, false);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                if DetailedVendLedgEntry."Vendor Ledger Entry No." <> DetailedVendLedgEntry."Applied Vend. Ledger Entry No." then begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Vendor Ledger Entry No.") then begin
                        if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin

                            if AppliedVendLedgerEntry."Fiscal Invoice Number PAC" <> '' then begin
                                FiscalNumbers := AddFiscalNumber(FiscalNumbers, AppliedVendLedgerEntry."Fiscal Invoice Number PAC");
                                ProcessedDocuments.Add(AppliedVendLedgerEntry."Document No.");
                            end
                            else if AppliedVendLedgerEntry."Document Type" = AppliedVendLedgerEntry."Document Type"::Invoice then begin
                                if PurchInvHeader.Get(AppliedVendLedgerEntry."Document No.") then begin
                                    if PurchInvHeader."Fiscal Invoice Number PAC" <> '' then begin
                                        FiscalNumbers := AddFiscalNumber(FiscalNumbers, PurchInvHeader."Fiscal Invoice Number PAC");
                                        ProcessedDocuments.Add(AppliedVendLedgerEntry."Document No.");
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            until DetailedVendLedgEntry.Next() = 0;
        exit(FiscalNumbers);
    end;

    local procedure AddFiscalNumber(CurrentNumbers: Text; NewNumber: Text): Text
    begin
        if NewNumber = '' then
            exit(CurrentNumbers);

        if StrPos(CurrentNumbers, NewNumber) > 0 then
            exit(CurrentNumbers);

        if CurrentNumbers <> '' then
            CurrentNumbers += ', ';

        CurrentNumbers += NewNumber;

        exit(CurrentNumbers);
    end;


    procedure GetVendorLedgerInfo(VATEntryNo: Integer; var OutSourceCode: Code[10]; var OutJournalBatchName: Code[10])
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        OutSourceCode := '';
        OutJournalBatchName := '';

        IF NOT VATEntry.GET(VATEntryNo) THEN
            EXIT;

        VendLedgerEntry.RESET;
        VendLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SETRANGE("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SETRANGE("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SETRANGE("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SETRANGE("Posting Date", VATEntry."Posting Date");

        IF VendLedgerEntry.FINDFIRST THEN BEGIN
            OutSourceCode := VendLedgerEntry."Source Code";
            OutJournalBatchName := VendLedgerEntry."Journal Batch Name";
        END;
    end;

    procedure GetAppliedDocumentDates(VATEntryNo: Integer): Text
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentDates: Text;
    begin
        DocumentDates := '';

        IF NOT VATEntry.GET(VATEntryNo) THEN
            EXIT('');

        VendLedgerEntry.RESET;
        VendLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SETRANGE("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SETRANGE("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SETRANGE("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SETRANGE("Posting Date", VATEntry."Posting Date");

        IF VendLedgerEntry.FINDFIRST THEN BEGIN
            IF VendLedgerEntry."Remaining Amount" = 0 THEN
                DocumentDates := GetAppliedDocumentDatesFromEntry(VendLedgerEntry."Entry No.");
        END;

        EXIT(DocumentDates);
    end;

    procedure GetAppliedDocumentDatesFromEntry(EntryNo: Integer): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DetailedVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentDates: Text;
        ProcessedEntries: List of [Integer];
    begin
        DocumentDates := '';

        IF NOT VendLedgerEntry.GET(EntryNo) THEN
            EXIT('');

        DetailedVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
        DetailedVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry1.SETRANGE(Unapplied, FALSE);

        IF DetailedVendLedgEntry1.FIND('-') THEN
            REPEAT
                IF DetailedVendLedgEntry1."Vendor Ledger Entry No." = DetailedVendLedgEntry1."Applied Vend. Ledger Entry No." THEN BEGIN
                    DetailedVendLedgEntry2.RESET;
                    DetailedVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                    DetailedVendLedgEntry2.SETRANGE("Applied Vend. Ledger Entry No.", DetailedVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DetailedVendLedgEntry2.SETRANGE("Entry Type", DetailedVendLedgEntry2."Entry Type"::Application);
                    DetailedVendLedgEntry2.SETRANGE(Unapplied, FALSE);

                    IF DetailedVendLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DetailedVendLedgEntry2."Vendor Ledger Entry No." <> DetailedVendLedgEntry2."Applied Vend. Ledger Entry No." THEN BEGIN
                                IF AppliedVendLedgerEntry.GET(DetailedVendLedgEntry2."Vendor Ledger Entry No.") THEN
                                    IF NOT ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") THEN BEGIN
                                        DocumentDates := AddDocumentDate(DocumentDates, AppliedVendLedgerEntry."Posting Date");
                                        ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                                    END;
                            END;
                        UNTIL DetailedVendLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    IF AppliedVendLedgerEntry.GET(DetailedVendLedgEntry1."Applied Vend. Ledger Entry No.") THEN
                        IF NOT ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") THEN BEGIN
                            DocumentDates := AddDocumentDate(DocumentDates, AppliedVendLedgerEntry."Posting Date");
                            ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                        END;
                END;
            UNTIL DetailedVendLedgEntry1.NEXT = 0;

        IF VendLedgerEntry."Closed by Entry No." <> 0 THEN BEGIN
            IF AppliedVendLedgerEntry.GET(VendLedgerEntry."Closed by Entry No.") THEN
                IF NOT ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") THEN BEGIN
                    DocumentDates := AddDocumentDate(DocumentDates, AppliedVendLedgerEntry."Posting Date");
                    ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                END;
        END;

        AppliedVendLedgerEntry.RESET;
        AppliedVendLedgerEntry.SETCURRENTKEY("Closed by Entry No.");
        AppliedVendLedgerEntry.SETRANGE("Closed by Entry No.", VendLedgerEntry."Entry No.");
        IF AppliedVendLedgerEntry.FIND('-') THEN
            REPEAT
                IF NOT ProcessedEntries.Contains(AppliedVendLedgerEntry."Entry No.") THEN BEGIN
                    DocumentDates := AddDocumentDate(DocumentDates, AppliedVendLedgerEntry."Posting Date");
                    ProcessedEntries.Add(AppliedVendLedgerEntry."Entry No.");
                END;
            UNTIL AppliedVendLedgerEntry.NEXT = 0;

        EXIT(DocumentDates);
    end;

    local procedure AddDocumentDate(CurrentDates: Text; NewDate: Date): Text
    var
        DateText: Text;
    begin
        DateText := FORMAT(NewDate, 0, '<Day,2>/<Month,2>/<Year4>');

        IF STRPOS(CurrentDates, DateText) > 0 THEN
            EXIT(CurrentDates);

        IF CurrentDates <> '' THEN
            CurrentDates += ', ';

        CurrentDates += DateText;

        EXIT(CurrentDates);
    end;

    procedure GetAppliedDocumentsFromVAT(VATEntryNo: Integer): Text
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentNumbers: Text;
        ProcessedDocuments: List of [Code[20]];
        FoundVendorMovement: Boolean;
    begin
        DocumentNumbers := '';
        FoundVendorMovement := false;

        if not VATEntry.Get(VATEntryNo) then
            exit('');

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            FoundVendorMovement := true;
            DocumentNumbers := ProcessVendorLedgerEntryForDocuments(VendLedgerEntry, ProcessedDocuments);

            if DocumentNumbers = '' then
                DocumentNumbers := SearchInSettledMovementsForDocuments(VendLedgerEntry, ProcessedDocuments);
        end;

        if not FoundVendorMovement or (DocumentNumbers = '') then begin
            DocumentNumbers := SearchDirectInVendorMovementsForDocuments(VATEntry, ProcessedDocuments);
        end;

        if DocumentNumbers = '' then begin
            DocumentNumbers := SearchAdditionalVendorMovementsForDocuments(VATEntry, ProcessedDocuments);
        end;

        exit(DocumentNumbers);
    end;

    local procedure ProcessVendorLedgerEntryForDocuments(VendLedgerEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        DocumentNumbers: Text;
    begin
        DocumentNumbers := '';

        DocumentNumbers := AddDocumentNumber(DocumentNumbers, VendLedgerEntry."Document No.");
        ProcessedDocuments.Add(VendLedgerEntry."Document No.");

        exit(DocumentNumbers);
    end;

    local procedure SearchDirectInVendorMovementsForDocuments(VATEntry: Record "VAT Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentNumbers: Text;
    begin
        DocumentNumbers := '';

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Posting Date");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(VendLedgerEntry."Document No.") then begin

                    DocumentNumbers := ProcessVendorLedgerEntryForDocuments(VendLedgerEntry, ProcessedDocuments);

                    if DocumentNumbers = '' then
                        DocumentNumbers := SearchInSettledMovementsForDocuments(VendLedgerEntry, ProcessedDocuments);

                    if DocumentNumbers <> '' then
                        break;
                end;
            until VendLedgerEntry.Next() = 0;

        exit(DocumentNumbers);
    end;

    local procedure SearchInSettledMovementsForDocuments(var VendLedgerEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentNumbers: Text;
    begin
        DocumentNumbers := '';

        DetailedVendLedgEntry.SetCurrentKey("Vendor Ledger Entry No.");
        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry.SetRange(Unapplied, false);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                if DetailedVendLedgEntry."Applied Vend. Ledger Entry No." <> DetailedVendLedgEntry."Vendor Ledger Entry No." then begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Applied Vend. Ledger Entry No.") then begin
                        if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                            DocumentNumbers := GetDocumentFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, DocumentNumbers);
                            if DocumentNumbers <> '' then
                                exit(DocumentNumbers);
                        end;
                    end;
                end;
            until DetailedVendLedgEntry.Next() = 0;

        DetailedVendLedgEntry.Reset();
        DetailedVendLedgEntry.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
        DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry.SetRange(Unapplied, false);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                if DetailedVendLedgEntry."Vendor Ledger Entry No." <> DetailedVendLedgEntry."Applied Vend. Ledger Entry No." then begin
                    if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Vendor Ledger Entry No.") then begin
                        if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                            DocumentNumbers := GetDocumentFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, DocumentNumbers);
                            if DocumentNumbers <> '' then
                                exit(DocumentNumbers);
                        end;
                    end;
                end;
            until DetailedVendLedgEntry.Next() = 0;

        if VendLedgerEntry."Closed by Entry No." <> 0 then begin
            if AppliedVendLedgerEntry.Get(VendLedgerEntry."Closed by Entry No.") then begin
                if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                    DocumentNumbers := GetDocumentFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, DocumentNumbers);
                    if DocumentNumbers <> '' then
                        exit(DocumentNumbers);
                end;
            end;
        end;

        AppliedVendLedgerEntry.Reset();
        AppliedVendLedgerEntry.SetCurrentKey("Closed by Entry No.");
        AppliedVendLedgerEntry.SetRange("Closed by Entry No.", VendLedgerEntry."Entry No.");
        if AppliedVendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(AppliedVendLedgerEntry."Document No.") then begin
                    DocumentNumbers := GetDocumentFromVendorEntry(AppliedVendLedgerEntry, ProcessedDocuments, DocumentNumbers);
                    if DocumentNumbers <> '' then
                        exit(DocumentNumbers);
                end;
            until AppliedVendLedgerEntry.Next() = 0;

        exit(DocumentNumbers);
    end;

    local procedure GetDocumentFromVendorEntry(var VendLedgerEntry: Record "Vendor Ledger Entry"; var ProcessedDocuments: List of [Code[20]]; CurrentDocumentNumbers: Text): Text
    var
        DocumentNumbers: Text;
    begin
        DocumentNumbers := CurrentDocumentNumbers;

        DocumentNumbers := AddDocumentNumber(DocumentNumbers, VendLedgerEntry."Document No.");
        ProcessedDocuments.Add(VendLedgerEntry."Document No.");

        exit(DocumentNumbers);
    end;

    local procedure SearchAdditionalVendorMovementsForDocuments(VATEntry: Record "VAT Entry"; var ProcessedDocuments: List of [Code[20]]): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentNumbers: Text;
    begin
        DocumentNumbers := '';

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", CalcDate('-7D', VATEntry."Posting Date"), CalcDate('+7D', VATEntry."Posting Date"));

        if VendLedgerEntry.FindSet() then
            repeat
                if not ProcessedDocuments.Contains(VendLedgerEntry."Document No.") then begin
                    DocumentNumbers := AddDocumentNumber(DocumentNumbers, VendLedgerEntry."Document No.");
                    ProcessedDocuments.Add(VendLedgerEntry."Document No.");
                    break;
                end;
            until VendLedgerEntry.Next() = 0;

        exit(DocumentNumbers);
    end;

    procedure GetAppliedDocuments(EntryNo: Integer): Text
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DetailedVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        DocumentNumbers: Text;
    begin
        DocumentNumbers := '';

        IF NOT VendLedgerEntry.GET(EntryNo) THEN
            EXIT('');

        DetailedVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
        DetailedVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DetailedVendLedgEntry1.SETRANGE(Unapplied, FALSE);

        IF DetailedVendLedgEntry1.FIND('-') THEN
            REPEAT
                IF DetailedVendLedgEntry1."Vendor Ledger Entry No." = DetailedVendLedgEntry1."Applied Vend. Ledger Entry No." THEN BEGIN
                    DetailedVendLedgEntry2.RESET;
                    DetailedVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                    DetailedVendLedgEntry2.SETRANGE("Applied Vend. Ledger Entry No.", DetailedVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DetailedVendLedgEntry2.SETRANGE("Entry Type", DetailedVendLedgEntry2."Entry Type"::Application);
                    DetailedVendLedgEntry2.SETRANGE(Unapplied, FALSE);

                    IF DetailedVendLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DetailedVendLedgEntry2."Vendor Ledger Entry No." <> DetailedVendLedgEntry2."Applied Vend. Ledger Entry No." THEN BEGIN
                                IF AppliedVendLedgerEntry.GET(DetailedVendLedgEntry2."Vendor Ledger Entry No.") THEN
                                    DocumentNumbers := AddDocumentNumber(DocumentNumbers, AppliedVendLedgerEntry."Document No.");
                            END;
                        UNTIL DetailedVendLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    IF AppliedVendLedgerEntry.GET(DetailedVendLedgEntry1."Applied Vend. Ledger Entry No.") THEN
                        DocumentNumbers := AddDocumentNumber(DocumentNumbers, AppliedVendLedgerEntry."Document No.");
                END;
            UNTIL DetailedVendLedgEntry1.NEXT = 0;

        IF VendLedgerEntry."Closed by Entry No." <> 0 THEN BEGIN
            IF AppliedVendLedgerEntry.GET(VendLedgerEntry."Closed by Entry No.") THEN
                DocumentNumbers := AddDocumentNumber(DocumentNumbers, AppliedVendLedgerEntry."Document No.");
        END;

        AppliedVendLedgerEntry.RESET;
        AppliedVendLedgerEntry.SETCURRENTKEY("Closed by Entry No.");
        AppliedVendLedgerEntry.SETRANGE("Closed by Entry No.", VendLedgerEntry."Entry No.");
        IF AppliedVendLedgerEntry.FIND('-') THEN
            REPEAT
                DocumentNumbers := AddDocumentNumber(DocumentNumbers, AppliedVendLedgerEntry."Document No.");
            UNTIL AppliedVendLedgerEntry.NEXT = 0;

        EXIT(DocumentNumbers);
    end;

    local procedure AddDocumentNumber(CurrentDocuments: Text; NewDocument: Text): Text
    begin
        if NewDocument = '' then
            exit(CurrentDocuments);

        if StrPos(CurrentDocuments, NewDocument) > 0 then
            exit(CurrentDocuments);

        if CurrentDocuments <> '' then
            CurrentDocuments += NewDocument;

        exit(CurrentDocuments);
    end;

    local procedure CreateVATDateFilter()
    begin
        if EnteredEndDate = 0D then
            VATEntry.SetFilter("VAT Reporting Date", '%1..', EntrdStartDate)
        else
            VATEntry.SetRange("VAT Reporting Date", EntrdStartDate, EnteredEndDate);
        DateFilter := VATEntry.GetFilter("VAT Reporting Date");
    end;

    local procedure GetCurrency(): Code[10]
    begin
        if UseAmtsInAddCurr then
            exit(GLSetup."Additional Reporting Currency");

        exit('');
    end;

    local procedure PostGenJnlLine(var GenJnlLine: Record "Gen. Journal Line")
    var
        DimMgt: Codeunit DimensionManagement;
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::"G/L Account", GenJnlLine."Account No.");
        DimMgt.AddDimSource(DefaultDimSource, Database::"G/L Account", GenJnlLine."Bal. Account No.");
        GenJnlLine."Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            GenJnlLine, 0, DefaultDimSource, GenJnlLine."Source Code",
            GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code", 0, 0);
        OnPostGenJnlLineOnBeforeGenJnlPostLineRun(GenJnlLine);
        GenJnlPostLine.Run(GenJnlLine);
    end;

    local procedure CopyAmounts(var GenJournalLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry")
    begin
        GenJournalLine.Amount := -VATEntry.Amount;
        GenJournalLine."VAT Amount" := -VATEntry.Amount;
        GenJournalLine."VAT Base Amount" := -VATEntry.Base;
        GenJournalLine."Source Currency Code" := GLSetup."Additional Reporting Currency";
        GenJournalLine."Source Currency Amount" := -VATEntry."Additional-Currency Amount";
        GenJournalLine."Source Curr. VAT Amount" := -VATEntry."Additional-Currency Amount";
        GenJournalLine."Source Curr. VAT Base Amount" := -VATEntry."Additional-Currency Base";
        GenJournalLine."Non-Deductible VAT Amount" := -VATEntry."Non-Deductible VAT Amount";
        GenJournalLine."Non-Deductible VAT Amount LCY" := -VATEntry."Non-Deductible VAT Amount";
        GenJournalLine."Non-Deductible VAT Amount ACY" := -VATEntry."Non-Deductible VAT Amount ACY";
        GenJournalLine."Non-Deductible VAT Base" := -VATEntry."Non-Deductible VAT Base";
        GenJournalLine."Non-Deductible VAT Base LCY" := -VATEntry."Non-Deductible VAT Base";
        GenJournalLine."Non-Deductible VAT Base ACY" := -VATEntry."Non-Deductible VAT Base ACY";
        OnAfterCopyAmounts(GenJournalLine, VATEntry);
    end;

    procedure GetPaymentMethodsFromVAT(VATEntryNo: Integer; var OutPaymentMethodCode: Code[10]; var OutFormToPayCode: Code[10])
    var
        VATEntry: Record "VAT Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        OutPaymentMethodCode := '';
        OutFormToPayCode := '';

        if not VATEntry.Get(VATEntryNo) then
            exit;

        VendLedgerEntry.Reset();
        VendLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendLedgerEntry.SetRange("Document No.", VATEntry."Document No.");
        VendLedgerEntry.SetRange("Document Type", VATEntry."Document Type");
        VendLedgerEntry.SetRange("Vendor No.", VATEntry."Bill-to/Pay-to No.");
        VendLedgerEntry.SetRange("Posting Date", VATEntry."Posting Date");

        if VendLedgerEntry.FindFirst() then begin
            if VendLedgerEntry."Payment Method Code" <> '' then
                OutPaymentMethodCode := VendLedgerEntry."Payment Method Code";

            if VendLedgerEntry."Document Type" = VendLedgerEntry."Document Type"::Invoice then begin
                if PurchInvHeader.Get(VendLedgerEntry."Document No.") then begin
                    if OutFormToPayCode = '' then
                        OutFormToPayCode := PurchInvHeader."Form to Pay";

                    if (OutPaymentMethodCode = '') and (PurchInvHeader."Payment Method Code" <> '') then
                        OutPaymentMethodCode := PurchInvHeader."Payment Method Code";

                    if (OutPaymentMethodCode <> '') and (OutFormToPayCode <> '') then
                        exit;
                end;
            end;

            if VendLedgerEntry."Remaining Amount" = 0 then begin
                DetailedVendLedgEntry.SetCurrentKey("Vendor Ledger Entry No.");
                DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
                DetailedVendLedgEntry.SetRange(Unapplied, false);
                DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

                if DetailedVendLedgEntry.FindSet() then
                    repeat
                        if DetailedVendLedgEntry."Applied Vend. Ledger Entry No." <> DetailedVendLedgEntry."Vendor Ledger Entry No." then begin
                            if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Applied Vend. Ledger Entry No.") then begin
                                if (OutPaymentMethodCode = '') and (AppliedVendLedgerEntry."Payment Method Code" <> '') then
                                    OutPaymentMethodCode := AppliedVendLedgerEntry."Payment Method Code";

                                if AppliedVendLedgerEntry."Document Type" = AppliedVendLedgerEntry."Document Type"::Invoice then begin
                                    if PurchInvHeader.Get(AppliedVendLedgerEntry."Document No.") then begin

                                        if (OutFormToPayCode = '') and (PurchInvHeader."Form to Pay" <> '') then
                                            OutFormToPayCode := PurchInvHeader."Form to Pay";

                                        if (OutPaymentMethodCode = '') and (PurchInvHeader."Payment Method Code" <> '') then
                                            OutPaymentMethodCode := PurchInvHeader."Payment Method Code";

                                        if (OutPaymentMethodCode <> '') and (OutFormToPayCode <> '') then
                                            exit;
                                    end;
                                end;
                            end;
                        end;
                    until DetailedVendLedgEntry.Next() = 0;

                DetailedVendLedgEntry.Reset();
                DetailedVendLedgEntry.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
                DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", VendLedgerEntry."Entry No.");
                DetailedVendLedgEntry.SetRange(Unapplied, false);
                DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);

                if DetailedVendLedgEntry.FindSet() then
                    repeat
                        if DetailedVendLedgEntry."Vendor Ledger Entry No." <> DetailedVendLedgEntry."Applied Vend. Ledger Entry No." then begin
                            if AppliedVendLedgerEntry.Get(DetailedVendLedgEntry."Vendor Ledger Entry No.") then begin

                                if (OutPaymentMethodCode = '') and (AppliedVendLedgerEntry."Payment Method Code" <> '') then
                                    OutPaymentMethodCode := AppliedVendLedgerEntry."Payment Method Code";

                                if AppliedVendLedgerEntry."Document Type" = AppliedVendLedgerEntry."Document Type"::Invoice then begin
                                    if PurchInvHeader.Get(AppliedVendLedgerEntry."Document No.") then begin

                                        if (OutFormToPayCode = '') and (PurchInvHeader."Form to Pay" <> '') then
                                            OutFormToPayCode := PurchInvHeader."Form to Pay";

                                        if (OutPaymentMethodCode = '') and (PurchInvHeader."Payment Method Code" <> '') then
                                            OutPaymentMethodCode := PurchInvHeader."Payment Method Code";

                                        if (OutPaymentMethodCode <> '') and (OutFormToPayCode <> '') then
                                            exit;
                                    end;
                                end;
                            end;
                        end;
                    until DetailedVendLedgEntry.Next() = 0;

                if VendLedgerEntry."Closed by Entry No." <> 0 then begin
                    if AppliedVendLedgerEntry.Get(VendLedgerEntry."Closed by Entry No.") then begin
                        if (OutPaymentMethodCode = '') and (AppliedVendLedgerEntry."Payment Method Code" <> '') then
                            OutPaymentMethodCode := AppliedVendLedgerEntry."Payment Method Code";

                        if AppliedVendLedgerEntry."Document Type" = AppliedVendLedgerEntry."Document Type"::Invoice then begin
                            if PurchInvHeader.Get(AppliedVendLedgerEntry."Document No.") then begin
                                if (OutFormToPayCode = '') and (PurchInvHeader."Form to Pay" <> '') then
                                    OutFormToPayCode := PurchInvHeader."Form to Pay";

                                if (OutPaymentMethodCode = '') and (PurchInvHeader."Payment Method Code" <> '') then
                                    OutPaymentMethodCode := PurchInvHeader."Payment Method Code";
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local procedure CreateGenJnlLine(var GenJnlLine2: Record "Gen. Journal Line"; AccountNo: Code[20]; Amount: Decimal; AmountACY: Decimal)
    begin
        Clear(GenJnlLine2);
        GenJnlLine2."System-Created Entry" := true;
        GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"G/L Account";
        GenJnlLine2.Description := GenJnlLine.Description;
        GenJnlLine2."Posting Date" := PostingDate;
        GenJnlLine2."VAT Reporting Date" := VATDate;
        GenJnlLine2."Document Type" := GenJnlLine2."Document Type"::" ";
        GenJnlLine2."Document No." := DocNo;
        GenJnlLine2."Source Code" := SourceCodeSetup."VAT Settlement";
        GenJnlLine2."VAT Posting" := GenJnlLine2."VAT Posting"::"Manual VAT Entry";
        GenJnlLine2."Account No." := AccountNo;
        GenJnlLine2.Amount := Amount;
        GenJnlLine2."Source Currency Code" := GLSetup."Additional Reporting Currency";
        GenJnlLine2."Source Currency Amount" := AmountACY;
    end;

    local procedure SetVatPostingSetupToGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; VATPostingSetup: Record "VAT Posting Setup")
    begin
        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Settlement;
        GenJnlLine."VAT Bus. Posting Group" := VATPostingSetup."VAT Bus. Posting Group";
        GenJnlLine."VAT Prod. Posting Group" := VATPostingSetup."VAT Prod. Posting Group";
        GenJnlLine."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
    end;

    local procedure CloseVATEntriesOnPostSettlement(var VATEntry: Record "VAT Entry"; NextVATEntryNo: Integer)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCloseVATEntriesOnPostSettlement(VATEntry, NextVATEntryNo, IsHandled);
        if IsHandled then
            exit;

        VATEntry.ModifyAll("Closed by Entry No.", NextVATEntryNo);
        VATEntry.ModifyAll(Closed, true);
    end;

    local procedure IsNotSettlement(GenPostingType: Enum "General Posting Type"): Boolean
    begin
        exit(
            (GenPostingType = GenPostingType::" ") or
            (GenPostingType = GenPostingType::Purchase)
            //(GenPostingType = GenPostingType::Sale)
            );
    end;

    local procedure GetSettlementVATEntryNo(PostVATSettlement: Boolean): Integer
    var
        NextAvailableVATEntryNo: Integer;
        LastPostedVATEntryNo: Integer;
    begin
        if PostVATSettlement then begin
            NextAvailableVATEntryNo := GenJnlPostLine.GetNextVATEntryNo();
            if NextAvailableVATEntryNo <> 0 then
                LastPostedVATEntryNo := NextAvailableVATEntryNo - 1;
            exit(LastPostedVATEntryNo);
        end;

        NextVATEntryNo += 1;
        exit(NextVATEntryNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPreReport(var VATEntry: Record "VAT Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostReport()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckPrintVATEntries(var VATEntry: Record "VAT Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostGenJnlLineReverseChargeVAT(var GenJnlLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var VATAmount: Decimal; var VATAmountAddCurr: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePreReport(var VATPostingSetup: Record "VAT Posting Setup"; PostSettlement: Boolean; GLAccountSettle: Record "G/L Account")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCloseVATEntriesOnPostSettlement(var VATEntry: Record "VAT Entry"; NextVATEntryNo: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterIncrementGenPostingType(OldGenPostingType: Enum "General Posting Type"; var NewGenPostingType: Enum "General Posting Type")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnClosingGLAndVATEntryOnAfterGetRecordOnAfterSetVATEntryFilters(VATPostingSetup: Record "VAT Posting Setup"; var VATEntry: Record "VAT Entry"; var VATEntry2: Record "VAT Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCloseVATEntriesOnAfterPostGenJnlLineReverseChargeVATSales(var VATEntry: Record "VAT Entry"; GenJnlLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; VATPostingSetup: Record "VAT Posting Setup"; PostSettlement: Boolean; var ReversingEntry: Boolean; DocNo: Code[20]; PostingDate: Date; var GenJnlLine2: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnClosingGLAndVATEntryOnAfterGetRecordOnNormalVATOnAfterVATEntrySetFilter(VATPostingSetup: Record "VAT Posting Setup"; VATType: enum "General Posting Type"; var VATEntry: Record "VAT Entry"; FindFirstEntry: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnClosingGLAndVATEntryOnAfterGetRecordOnSalesTaxOnAfterVATEntrySetFilter(VATPostingSetup: Record "VAT Posting Setup"; VATType: enum "General Posting Type"; var VATEntry: Record "VAT Entry"; FindFirstEntry: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostGenJnlLineOnBeforeGenJnlPostLineRun(var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyAmounts(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry")
    begin
    end;
}
