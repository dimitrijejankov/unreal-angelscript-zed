// Test Unreal Angelscript file

#include "CoreUObject.h"

UCLASS(BlueprintType, Blueprintable)
class UMyActor : public AActor
{
    GENERATED_BODY()

public:
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Test")
    float TestValue = 1.0f;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Test")
    FString TestString = "Hello World";

    UFUNCTION(BlueprintCallable, Category = "Test")
    void TestFunction(float InputValue)
    {
        TestValue = InputValue;
        Print("Test function called with value: " + InputValue);
    }

    UFUNCTION(BlueprintPure, Category = "Test")
    bool IsTestValueValid() const
    {
        return TestValue > 0.0f;
    }

    // Constructor
    UMyActor()
    {
        PrimaryActorTick.bCanEverTick = true;
    }

    // BeginPlay override
    virtual void BeginPlay() override
    {
        Super::BeginPlay();
        TestFunction(10.0f);

        // Test conditionals
        if (TestValue > 5.0f)
        {
            Print("Test value is greater than 5");
        }
        else
        {
            Print("Test value is less than or equal to 5");
        }

        // Test loop
        for (int i = 0; i < 5; i++)
        {
            Print("Loop iteration: " + i);
        }

        // Test switch
        switch (int(TestValue))
        {
            case 1:
                Print("Value is 1");
                break;
            case 10:
                Print("Value is 10");
                break;
            default:
                Print("Value is something else");
                break;
        }
    }

protected:
    UFUNCTION(BlueprintImplementableEvent, Category = "Test")
    void OnTestEvent();

private:
    UPROPERTY()
    TArray<FString> StringArray;
};

// Test enum
UENUM(BlueprintType)
enum class ETestEnum : uint8
{
    None    UMETA(DisplayName = "None"),
    First   UMETA(DisplayName = "First"),
    Second  UMETA(DisplayName = "Second"),
    Third   UMETA(DisplayName = "Third"),
};

// Test struct
USTRUCT(BlueprintType)
struct FTestStruct
{
    GENERATED_BODY()

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Test")
    FVector Location = FVector::ZeroVector;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Test")
    FRotator Rotation = FRotator::ZeroRotator;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Test")
    bool bIsEnabled = false;
};

// Test delegate
DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnTestDelegate, int32, TestValue);

// Test global function
void GlobalTestFunction()
{
    Print("This is a global test function");
}

// Test namespace
namespace TestNamespace
{
    void NamespaceFunction()
    {
        Print("This is a namespace function");
    }

    class NamespaceClass
    {
        void DoSomething()
        {
            Print("Doing something in a namespace class");
        }
    };
}
